//
//  PostsRepositoryMock.swift
//  HealiosTests
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

import RxSwift
@testable import Healios

class PostsRepositoryMock: PostsRepositoryProtocol {

    var posts: Observable<[PostModel]> {
        .just(testPosts)
    }

    func refreshPosts() -> Completable {
        .empty()
    }

    private var testPosts: [PostModel] {
        let user1 = UserModel(
            email: "testemail",
            id: 1,
            name: "Test Test",
            phone: "12345",
            username: "test1",
            website: "",
            address: AddressModel(
                city: "Zagreb",
                street: "Second street",
                suite: "22",
                zipcode: "1000",
                geo: GeoModel(latitude: "23", longitude: "24")
            ),
            company: CompanyModel(
                bs: "bs",
                catchPhrase: "test",
                name: "Test Company"
            )
        )
        let user2 = UserModel(
            email: "testemail2",
            id: 2,
            name: "Test Test",
            phone: "12345",
            username: "test2",
            website: "",
            address: AddressModel(
                city: "Zagreb",
                street: "Second street",
                suite: "22",
                zipcode: "1000",
                geo: GeoModel(latitude: "23", longitude: "24")
            ),
            company: CompanyModel(
                bs: "bs",
                catchPhrase: "test",
                name: "Test Company"
            )
        )
        let comments1 = [
            CommentModel(body: "comment1", email: "testemail3", id: 1, name: "comment1"),
            CommentModel(body: "comment2", email: "testemail4", id: 2, name: "comment2")
        ]
        let comments2 = [
            CommentModel(body: "comment11", email: "testemail3", id: 11, name: "comment11"),
            CommentModel(body: "comment12", email: "testemail4", id: 12, name: "comment12")
        ]
        return [
            PostModel(body: "test body1", id: 1, title: "test title1", comments: [], user: user1),
            PostModel(body: "test body2", id: 2, title: "test title2", comments: comments1, user: user1),
            PostModel(body: "test body3", id: 3, title: "test title3", comments: comments2, user: user2)
        ]
    }

}
