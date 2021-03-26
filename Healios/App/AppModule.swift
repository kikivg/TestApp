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
        registerNetworkService()
        registerRepository()
        registerRouter()
        registerPostsViewController()
    }

    private func registerRouter() {
        container.register(.singleton, factory: AppRouter.init)
    }

    private func registerPostsViewController() {
        container.register(.unique, factory: PostsPresenter.init)

        container.register(.unique) { [unowned container] _ -> PostsViewController in
            let presenter: PostsPresenter = try container.resolve()
            return PostsViewController(presenter: presenter)
        }
    }

    private func registerPersistence() {
        container.register(.unique) { _ -> CoreDataStack in
            return CoreDataStack()
        }

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

    private func registerNetworkService() {
        container.register(
            .singleton,
            type: Networkable.self,
            factory: NetworkService.init
        )
    }

}
