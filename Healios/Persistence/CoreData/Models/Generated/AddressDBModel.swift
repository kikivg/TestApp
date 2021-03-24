//
//  AddressDBModel.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import CoreData

class AddressDBModel: NSManagedObject {

    @NSManaged private(set) var city: String
    @NSManaged private(set) var street: String
    @NSManaged private(set) var suite: String
    @NSManaged private(set) var zipcode: String
    @NSManaged private(set) var geo: GeoDBModel
    @NSManaged private(set) var user: UserDBModel

    @discardableResult
    static func insert(into context: NSManagedObjectContext, from addressAPI: AddressAPIModel) -> AddressDBModel {
        let address: AddressDBModel = context.insertObject()
        address.street = addressAPI.street
        address.suite = addressAPI.suite
        address.city = addressAPI.city
        address.zipcode = addressAPI.zipcode

        let geo = GeoDBModel.insert(into: context, from: addressAPI.geo)
        address.geo = geo

        return address
    }

    func toModel() -> AddressModel {
        AddressModel(
            city: city,
            street: street,
            suite: suite,
            zipcode: zipcode,
            geo: geo.toModel()
        )
    }

}

extension AddressDBModel: CoreDataManagedType {}
