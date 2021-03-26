//
//  PostsPresenter.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 25/03/2021.
//

import RxSwift

class PostsPresenter {

    private let postsRepository: PostsRepositoryProtocol
    private let appRouter: AppRouter
    private var postsDict = [Int: PostModel]()

    init(postsRepository: PostsRepositoryProtocol, appRouter: AppRouter) {
        self.postsRepository = postsRepository
        self.appRouter = appRouter
    }

    private lazy var posts: Observable<[PostModel]> = {
        postsRepository.posts
            .do(onNext: { [weak self] posts in
                self?.updatePosts(posts: posts)
            })
            .share(replay: 1)
    }()

    var postsExist: Observable<Bool> {
        posts.map { !$0.isEmpty }
    }

    var postViewModels: Observable<[PostListViewModel]> {
        posts.map { $0.map { PostListViewModel(from: $0) } }
    }

    func refreshPosts() -> Completable {
        postsRepository.refreshPosts()
    }

    func postSelected(postId: Int) {
        guard let post = postsDict[postId] else {
            return
        }
        appRouter.pushPostDetailsViewController(post: post)
    }

    private func updatePosts(posts: [PostModel]) {
        postsDict = posts.associateBy { $0.id }
    }

}
