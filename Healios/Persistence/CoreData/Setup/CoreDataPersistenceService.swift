//
//  CoreDataPersistenceService.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import CoreData
import RxSwift

class CoreDataPersistenceService: PersistenceProtocol {

    private let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }

    func fetchPosts() -> Observable<[PostModel]> {
        PostDBModel.fetch(in: coreDataStack.mainContext)
            .map { $0.map { $0.toModel() } }
    }

    func persist(posts: [PostAPIModel], users: [UserAPIModel], comments: [CommentAPIModel]) -> Completable {
        let context = coreDataStack.backgroundContext

        return Completable.create { completable in
            context.performAndSave(completable: completable) {
                let usersById = users.reduce(into: [:], { dict, user in
                    dict[user.id] = UserDBModel.insert(into: context, from: user)
                })
                let postsById = posts.reduce(into: [:], { dict, post in
                    dict[post.id] = PostDBModel.insert(into: context, from: post, and: usersById)
                })
                comments.forEach { CommentDBModel.insert(into: context, from: $0, and: postsById) }
            }
            return Disposables.create()
        }
    }

}
