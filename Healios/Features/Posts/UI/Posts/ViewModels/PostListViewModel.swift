//
//  PostListViewModel.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

struct PostListViewModel {

    let id: Int
    let title: String
    let body: String
    let userNickname: String
    let numberOfComments: Int

    init(from model: PostModel) {
        id = model.id
        title = model.title
        body = model.body
        userNickname = model.user.username
        numberOfComments = model.comments.count
    }

}
