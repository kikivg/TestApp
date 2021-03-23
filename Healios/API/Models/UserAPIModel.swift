//
//  UserAPIModel.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

struct UserAPIModel: Codable {

    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: AddressAPIModel
    let company: CompanyAPIModel

}

