//
//  PostsRepositoryProtocol.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 25/03/2021.
//

import RxSwift

protocol PostsRepositoryProtocol {

    var posts: Observable<[PostModel]> { get }

    func refreshPosts() -> Completable

}
