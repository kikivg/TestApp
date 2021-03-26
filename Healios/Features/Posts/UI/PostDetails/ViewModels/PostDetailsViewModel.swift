//
//  PostDetailsViewModel.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

struct PostDetailsViewModel {

    let title: String
    let body: String
    let user: UserViewModel
    let comments: [CommentViewModel]

    init(from model: PostModel) {
        title = model.title
        body = model.body
        user = UserViewModel(from: model.user)
        comments = model.comments.map { CommentViewModel(from: $0) }
    }

}
