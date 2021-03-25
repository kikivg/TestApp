//
//  CoreDataManagedType.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import CoreData
import RxSwift

protocol CoreDataManagedType: NSFetchRequestResult {

    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }

}

extension CoreDataManagedType where Self: NSManagedObject {

    static var entityName: String {
        return String(describing: self)
    }

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }

    static var sortedFetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }

    static func predicateId(for id: String) -> NSPredicate {
        NSPredicate(format: "id == %@", id)
    }

    static func fetch(in context: NSManagedObjectContext, matching predicate: NSPredicate? = nil) -> Observable<[Self]> {
        let request = sortedFetchRequest
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        return context.rx.entities(fetchRequest: request)
    }

    static func first(in context: NSManagedObjectContext, matching predicate: NSPredicate? = nil) -> Self? {
        let request = sortedFetchRequest
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        var results: [Self]?
        context.performAndWait {
            results = try? context.fetch(request)
        }
        return results?.first
    }

    static func deleteAll(from context: NSManagedObjectContext) {
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.includesPropertyValues = false
        let items = try! context.fetch(request)
        for item in items {
            context.delete(item)
        }
    }

}
