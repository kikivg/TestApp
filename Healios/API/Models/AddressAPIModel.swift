//
//  AddressAPIModel.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

struct AddressAPIModel: Codable {

    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: GeoAPIModel

}
