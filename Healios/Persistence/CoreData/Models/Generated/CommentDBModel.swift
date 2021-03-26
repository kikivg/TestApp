//
//  CommentDBModel.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import CoreData

class CommentDBModel: NSManagedObject {

    @NSManaged private(set) var body: String
    @NSManaged private(set) var email: String
    @NSManaged private(set) var id: Int
    @NSManaged private(set) var name: String
    @NSManaged private(set) var post: PostDBModel

    @discardableResult
    static func insert(
        into context: NSManagedObjectContext,
        from commentAPI: CommentAPIModel,
        and post: PostDBModel?
    ) -> CommentDBModel {
        let comment: CommentDBModel = context.insertObject()
        comment.id = commentAPI.id
        comment.name = commentAPI.name
        comment.email = commentAPI.email
        comment.body = commentAPI.body

        if let post = post {
            comment.post = post
        }

        return comment
    }

    func toModel() -> CommentModel {
        CommentModel(
            body: body,
            email: email,
            id: id,
            name: name
        )
    }

}

extension CommentDBModel: CoreDataManagedType {

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(id), ascending: true)]
    }

}
