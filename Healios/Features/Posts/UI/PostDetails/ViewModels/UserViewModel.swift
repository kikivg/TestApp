//
//  UserViewModel.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

struct UserViewModel {

    let name: String
    let username: String
    let email: String

    init(from model: UserModel) {
        name = model.name
        username = model.username
        email = model.email
    }

}
