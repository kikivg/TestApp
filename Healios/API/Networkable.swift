//
//  Networkable.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import RxSwift

protocol Networkable {

    func getPosts() -> Observable<[PostAPIModel]>

    func getUsers() -> Observable<[UserAPIModel]>

    func getComments() -> Observable<[CommentAPIModel]>

}
