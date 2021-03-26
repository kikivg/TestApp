//
//  UserDBModel.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import CoreData

class UserDBModel: NSManagedObject {

    @NSManaged private(set) var email: String
    @NSManaged private(set) var id: Int
    @NSManaged private(set) var name: String
    @NSManaged private(set) var phone: String
    @NSManaged private(set) var username: String
    @NSManaged private(set) var website: String
    @NSManaged private(set) var address: AddressDBModel
    @NSManaged private(set) var company: CompanyDBModel
    @NSManaged private(set) var posts: Set<PostDBModel>

    @discardableResult
    static func insert(into context: NSManagedObjectContext, from userAPI: UserAPIModel) -> UserDBModel {
        let user: UserDBModel = context.insertObject()
        user.id = userAPI.id
        user.name = userAPI.name
        user.username = userAPI.username
        user.email = userAPI.email
        user.phone = userAPI.phone
        user.website = userAPI.website

        let address = AddressDBModel.insert(into: context, from: userAPI.address)
        user.address = address

        let company = CompanyDBModel.insert(into: context, from: userAPI.company)
        user.company = company

        return user
    }

    func toModel() -> UserModel {
        UserModel(
            email: email,
            id: id,
            name: name,
            phone: phone,
            username: username,
            website: website,
            address: address.toModel(),
            company: company.toModel()
        )
    }

}

extension UserDBModel: CoreDataManagedType {}

// MARK: Generated accessors for posts
extension UserDBModel {

    @objc(addPostsObject:)
    @NSManaged func addToPosts(_ value: PostDBModel)

    @objc(removePostsObject:)
    @NSManaged func removeFromPosts(_ value: PostDBModel)

    @objc(addPosts:)
    @NSManaged func addToPosts(_ values: Set<PostDBModel>)

    @objc(removePosts:)
    @NSManaged func removeFromPosts(_ values: Set<PostDBModel>)

}

