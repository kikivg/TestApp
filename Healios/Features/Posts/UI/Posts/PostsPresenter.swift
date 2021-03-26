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

    init(postsRepository: PostsRepositoryProtocol, appRouter: AppRouter) {
        self.postsRepository = postsRepository
        self.appRouter = appRouter
    }

    var posts: Observable<[PostModel]> {
        postsRepository.posts
    }

    func refreshPosts() -> Completable {
        postsRepository.refreshPosts()
    }

    func postSelected(post: PostModel) {
        appRouter.pushPostDetailsViewController(post: post)
    }

}
