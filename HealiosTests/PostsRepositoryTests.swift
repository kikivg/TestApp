//
//  HealiosTests.swift
//  HealiosTests
//
//  Created by Kristijan Rozankovic on 22/03/2021.
//

import XCTest
@testable import Healios
import Dip
import CoreData
import RxSwift
import RxBlocking

class PostsRepositoryTests: XCTestCase {

    let container = DependencyContainer()
    let disposeBag = DisposeBag()

    var postsRepository: PostsRepositoryProtocol!

    override func setUpWithError() throws {
        configureContainer()
    }

    func configureContainer() {
        container.register(
            .unique,
            type: Networkable.self,
            factory: NetworkServiceMock.init
        )

        container.register(.unique) { _ -> CoreDataStack in
            return CoreDataStack(storeType: NSInMemoryStoreType)
        }

        container.register(
            .unique,
            type: PersistenceProtocol.self,
            factory: CoreDataPersistenceService.init
        )

        container.register(
            .unique,
            type: PostsRepositoryProtocol.self,
            factory: PostsRepository.init
        )

        postsRepository = try! container.resolve()
    }

    override func tearDownWithError() throws {
        container.reset()
    }

    func getPosts() -> [PostModel] {
        let posts = try! postsRepository
            .refreshPosts()
            .andThen(postsRepository.posts)
            .toBlocking()
            .first() ?? []

        XCTAssertFalse(posts.isEmpty, "Error: posts don't exist!")

        return posts
    }

    func testPostsCount() {
        let posts = getPosts()
        XCTAssertEqual(posts.count, 7, "Error: posts count is wrong!")
    }

    func testCommentsCount() {
        let posts = getPosts()

        posts.forEach { post in
            XCTAssertTrue(!post.comments.isEmpty, "Error: comments don't exist!")
        }
    }

    func testPostOrder() {
        let posts = getPosts()

        let firstPost = posts[0]
        XCTAssertEqual(firstPost.id, 1, "Error: wrong first post!")

        let lastPost = posts[6]
        XCTAssertEqual(lastPost.id, 14, "Error: wrong last post!")
    }

    func testUniqueUsers() {
        let posts = getPosts()

        var users = Set<Int>()
        for post in posts {
            users.insert(post.user.id)
        }
        XCTAssertEqual(users.count, 2, "Error: wrong user count!")
    }

}
