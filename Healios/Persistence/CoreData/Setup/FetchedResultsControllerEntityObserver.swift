//
//  FetchedResultsControllerEntityObserver.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import CoreData
import RxSwift

final class FetchedResultsControllerEntityObserver<T: NSFetchRequestResult> : NSObject, NSFetchedResultsControllerDelegate {

    typealias Observer = AnyObserver<[T]>

    private let observer: Observer
    private let disposeBag = DisposeBag()
    private let frc: NSFetchedResultsController<T>

    init(
        observer: Observer,
        fetchRequest: NSFetchRequest<T>,
        managedObjectContext context: NSManagedObjectContext,
        sectionNameKeyPath: String?,
        cacheName: String?
    ) {
        self.observer = observer

        self.frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: sectionNameKeyPath,
            cacheName: cacheName)
        super.init()

        context.perform {
            self.frc.delegate = self

            do {
                try self.frc.performFetch()
            } catch let e {
                observer.on(.error(e))
            }

            self.sendNextElement()
        }
    }

    private func sendNextElement() {
        frc.managedObjectContext.perform {
            let entities = self.frc.fetchedObjects ?? []
            self.observer.on(.next(entities))
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        sendNextElement()
    }
}

extension FetchedResultsControllerEntityObserver : Disposable {

    func dispose() {
        frc.delegate = nil
    }

}
