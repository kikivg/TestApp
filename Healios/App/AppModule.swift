//
//  AppModule.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 22/03/2021.
//

import Dip

class AppModule {

    private let container: DependencyContainer

    init() {
        self.container = DependencyContainer()
    }

    var applicationRouter: AppRouter {
        return try! container.resolve()
    }

    func registerDependencies() {
        registerPersistence()
        registerRepository()
        registerRouter()
        registerPostsViewController()
    }

    private func registerRouter() {
        container.register(.singleton, factory: AppRouter.init)
    }

    private func registerPostsViewController() {
        container.register(.unique) { [unowned container] _ -> PostsViewController in
            return PostsViewController()
        }
    }

    private func registerPersistence() {
        container.register(.unique, factory: CoreDataStack.init)

        container.register(
            .singleton,
            type: PersistenceProtocol.self,
            factory: CoreDataPersistenceService.init
        )
    }

    private func registerRepository() {
        container.register(
            .singleton,
            type: PostsRepositoryProtocol.self,
            factory: PostsRepository.init
        )
    }

}
