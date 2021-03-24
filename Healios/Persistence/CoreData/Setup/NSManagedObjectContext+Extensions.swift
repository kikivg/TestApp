//
//  NSManagedObjectContext+Extensions.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import CoreData

extension NSManagedObjectContext {

    func insertObject<A: CoreDataManagedType>() -> A {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else {
            fatalError("Wrong object type")
        }
        return obj
    }

    func saveOrRollback() throws {
        do {
            try save()
        } catch(let error) {
            print(error)
            rollback()
            throw error
        }
    }

}

extension NSManagedObjectContext {

    func performMergeChangesFromContextDidSaveNotification(notification: Notification) {
        perform {
            self.mergeChanges(fromContextDidSave: notification)
        }
    }

}

