//
//  PostsRepository.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 25/03/2021.
//

import RxSwift

class PostsRepository: PostsRepositoryProtocol {

    let networkService: Networkable
    let persistanceService: PersistenceProtocol

    init(
        networkService: Networkable,
        persistanceService: PersistenceProtocol
    ) {
        self.networkService = networkService
        self.persistanceService = persistanceService
    }

    var posts: Observable<[PostModel]> {
        persistanceService.fetchPosts()
    }

    func refreshPosts() -> Completable {
        Observable.zip(networkService.getPosts(), networkService.getUsers(), networkService.getComments())
            .flatMapLatest { [weak self] posts, users, comments -> Observable<Never> in
                guard let self = self else { return .empty() }
                return self.persistanceService.persist(posts: posts, users: users, comments: comments).asObservable()
            }
            .asCompletable()
    }

}
