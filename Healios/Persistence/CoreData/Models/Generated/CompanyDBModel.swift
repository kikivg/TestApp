//
//  CompanyDBModel.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import CoreData

class CompanyDBModel: NSManagedObject {

    @NSManaged private(set) var bs: String
    @NSManaged private(set) var catchPhrase: String
    @NSManaged private(set) var name: String
    @NSManaged private(set) var user: UserDBModel

    @discardableResult
    static func insert(into context: NSManagedObjectContext, from companyAPI: CompanyAPIModel) -> CompanyDBModel {
        let company: CompanyDBModel = context.insertObject()
        company.name = companyAPI.name
        company.catchPhrase = companyAPI.catchPhrase
        company.bs = companyAPI.bs
        return company
    }

    func toModel() -> CompanyModel {
        CompanyModel(
            bs: bs,
            catchPhrase: catchPhrase,
            name: name
        )
    }

}

extension CompanyDBModel: CoreDataManagedType {}
