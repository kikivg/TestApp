//
//  PostDBModel.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import CoreData

class PostDBModel: NSManagedObject {

    @NSManaged private(set) var body: String
    @NSManaged private(set) var id: Int
    @NSManaged private(set) var title: String
    @NSManaged private(set) var comments: Set<CommentDBModel>
    @NSManaged private(set) var user: UserDBModel

    @discardableResult
    static func insert(
        into context: NSManagedObjectContext,
        from postAPI: PostAPIModel,
        and users: [Int: UserDBModel]
    ) -> PostDBModel {
        let post: PostDBModel = context.insertObject()
        post.id = postAPI.id
        post.title = postAPI.title
        post.body = postAPI.body

        if let user = users[postAPI.userId] {
            post.user = user
        }

        return post
    }

    func toModel() -> PostModel {
        PostModel(
            body: body,
            id: id,
            title: title,
            comments: comments.map { $0.toModel() },
            user: user.toModel()
        )
    }

}

extension PostDBModel: CoreDataManagedType {

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(id), ascending: true)]
    }

}

// MARK: Generated accessors for comments
extension PostDBModel {

    @objc(addCommentsObject:)
    @NSManaged func addToComments(_ value: CommentDBModel)

    @objc(removeCommentsObject:)
    @NSManaged func removeFromComments(_ value: CommentDBModel)

    @objc(addComments:)
    @NSManaged func addToComments(_ values: Set<CommentDBModel>)

    @objc(removeComments:)
    @NSManaged func removeFromComments(_ values: Set<CommentDBModel>)

}
