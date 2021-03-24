//
//  PostModel.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 24/03/2021.
//

struct PostModel {

    let body: String
    let id: Int
    let title: String
    let comments: [CommentModel]
    let user: UserModel

}
