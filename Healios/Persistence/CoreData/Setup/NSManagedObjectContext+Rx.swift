//
//  NSManagedObjectContext+Rx.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import RxSwift
import CoreData

extension Reactive where Base: NSManagedObjectContext {

    func entities<T: NSFetchRequestResult>(
        fetchRequest: NSFetchRequest<T>,
        sectionNameKeyPath: String? = nil,
        cacheName: String? = nil
    ) -> Observable<[T]> {
        return Observable.create { observer in
            let observerAdapter = FetchedResultsControllerEntityObserver(
                observer: observer,
                fetchRequest: fetchRequest,
                managedObjectContext: self.base,
                sectionNameKeyPath: sectionNameKeyPath,
                cacheName: cacheName)

            return Disposables.create {
                observerAdapter.dispose()
            }
        }
    }

}

extension NSManagedObjectContext {

    func tryToSave(completable: (CompletableEvent) -> Void) {
        do {
            try saveOrRollback()
            completable(.completed)
        } catch(let error) {
            completable(.error(error))
        }
    }

    func performAndSave(completable: @escaping (CompletableEvent) -> Void, action: @escaping () -> Void) {
        perform { [weak self] in
            action()
            self?.tryToSave(completable: completable)
        }
    }

}

