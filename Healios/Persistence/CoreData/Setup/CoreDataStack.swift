//
//  CoreDataStack.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import CoreData
import RxSwift
import RxCocoa

class CoreDataStack {

    private var storeURL: URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        return URL(fileURLWithPath: paths).appendingPathComponent("\(dataModelName).sqlite")
    }

    private let dataModelName = "Healios"
    private let persistanceCoordinator: NSPersistentStoreCoordinator
    let mainContext: NSManagedObjectContext
    let backgroundContext: NSManagedObjectContext
    private let disposeBag = DisposeBag()

    init(storeType: String = NSSQLiteStoreType) {
        guard let model = NSManagedObjectModel.mergedModel(from: [Bundle.main]) else {
            fatalError("Model not found!")
        }

        let migrationOptions = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true
        ]

        persistanceCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)

        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = persistanceCoordinator

        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.persistentStoreCoordinator = persistanceCoordinator

        do {
            try persistanceCoordinator.addPersistentStore(
                ofType: storeType,
                configurationName: nil,
                at: storeURL,
                options: migrationOptions)
        } catch {
            fatalError("Failed to add persistent store!")
        }

        setupContextNotificationObserving()
    }

    private func setupContextNotificationObserving() {
        NotificationCenter.default.rx
            .notification(.NSManagedObjectContextDidSave, object: mainContext)
            .subscribe(onNext: { [weak self] notification in
                self?.mainContextDidSave(notification: notification)
            })
            .disposed(by: disposeBag)

        NotificationCenter.default.rx
            .notification(.NSManagedObjectContextDidSave, object: backgroundContext)
            .subscribe(onNext: { [weak self] notification in
                self?.backgroundContextDidSave(notification: notification)
            })
            .disposed(by: disposeBag)
    }

    private func mainContextDidSave(notification: Notification) {
        backgroundContext.performMergeChangesFromContextDidSaveNotification(notification: notification)
    }

    private func backgroundContextDidSave(notification: Notification) {
        mainContext.performMergeChangesFromContextDidSaveNotification(notification: notification)
    }

}
