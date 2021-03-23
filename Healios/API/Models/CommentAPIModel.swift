//
//  CommentAPIModel.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

struct CommentAPIModel: Codable {

    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String

}
