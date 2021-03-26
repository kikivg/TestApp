//
//  CommentViewModel.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

struct CommentViewModel {

    let name: String
    let body: String
    let email: String

    init(from model: CommentModel) {
        name = model.name
        body = model.body
        email = model.email
    }

}
