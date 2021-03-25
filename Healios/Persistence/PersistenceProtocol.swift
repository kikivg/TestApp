//
//  PersistenceProtocol.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 24/03/2021.
//

import RxSwift

protocol PersistenceProtocol {

    func fetchPosts() -> Observable<[PostModel]>

    func persist(posts: [PostAPIModel], users: [UserAPIModel], comments: [CommentAPIModel]) -> Completable

}
