//
//  GeoDBModel.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import CoreData

class GeoDBModel: NSManagedObject {

    @NSManaged private(set) var latitude: String
    @NSManaged private(set) var longitude: String
    @NSManaged private(set) var address: AddressDBModel

    @discardableResult
    static func insert(into context: NSManagedObjectContext, from geoAPI: GeoAPIModel) -> GeoDBModel {
        let geo: GeoDBModel = context.insertObject()
        geo.latitude = geoAPI.lat
        geo.longitude = geoAPI.lng
        return geo
    }

    func toModel() -> GeoModel {
        GeoModel(latitude: latitude, longitude: longitude)
    }

}

extension GeoDBModel: CoreDataManagedType {}
