//
//  PostsPresenterTests.swift
//  HealiosTests
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

import XCTest
@testable import Healios
import Dip
import RxSwift
import RxBlocking

class PostsPresenterTests: XCTestCase {

    let container = DependencyContainer()
    let disposeBag = DisposeBag()

    var postsPresenter: PostsPresenter!

    func configureContainer() {
        let postsRepository = PostsRepositoryMock()
        let appRouter = AppRouterMock()
        postsPresenter = PostsPresenter(postsRepository: postsRepository, appRouter: appRouter)
    }

    override func setUpWithError() throws {
        configureContainer()
    }

    override func tearDownWithError() throws {
    }

    func getPosts() -> [PostListViewModel] {
        let posts = try! postsPresenter
            .postViewModels
            .toBlocking()
            .first() ?? []

        XCTAssertFalse(posts.isEmpty, "Error: posts don't exist!")

        return posts
    }

    func testPostsExist() {
        let postsExist = try! postsPresenter
            .postsExist
            .toBlocking()
            .first()

        XCTAssertTrue(postsExist ?? false, "Error: posts don't exist!")
    }

    func testPostsCount() {
        let posts = getPosts()
        XCTAssertEqual(posts.count, 3, "Error: posts count is wrong!")
    }

    func testUniqueUsers() {
        let posts = getPosts()

        var users = Set<String>()
        for post in posts {
            users.insert(post.userNickname)
        }
        XCTAssertEqual(users.count, 2, "Error: wrong user count!")
    }

    func testComments() {
        let posts = getPosts()

        let firstPost = posts[0]
        XCTAssertEqual(firstPost.numberOfComments, 0, "Error: wrong comment count!")

        let secondPost = posts[1]
        XCTAssertEqual(secondPost.numberOfComments, 2, "Error: wrong comment count!")

        let commentsCount = posts.reduce(0, { $0 + $1.numberOfComments })
        XCTAssertGreaterThan(commentsCount, 0, "Error: wrong comments count!")
        XCTAssertEqual(commentsCount, 4, "Error: wrong comments count!")
    }

}
