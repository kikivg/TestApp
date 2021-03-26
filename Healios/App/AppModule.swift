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

    var applicationRouter: AppRouterProtocol {
        return try! container.resolve()
    }

    func registerDependencies() {
        registerPersistence()
        registerNetworkService()
        registerRepository()
        registerRouter()
        registerPostsViewController()
        registerPostDetailsViewController()
    }

    private func registerRouter() {
        container.register(
            .singleton,
            type: AppRouterProtocol.self,
            factory: AppRouter.init
        )
    }

    private func registerPostsViewController() {
        container.register(.unique, factory: PostsPresenter.init)

        container.register(.unique) { [unowned container] _ -> PostsViewController in
            let presenter: PostsPresenter = try container.resolve()
            return PostsViewController(presenter: presenter)
        }
    }

    private func registerPostDetailsViewController() {
        container.register(.unique) { (post: PostModel) -> PostDetailsPresenter in
            return PostDetailsPresenter(post: post)
        }

        container.register(.unique) { [unowned container] (post: PostModel) -> PostDetailsViewController in
            let presenter: PostDetailsPresenter = try container.resolve(arguments: post)
            return PostDetailsViewController(presenter: presenter)
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
