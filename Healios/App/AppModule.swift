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
        registerPostsViewController()
        registerRouter()
    }

    private func registerRouter() {
        container.register(.singleton, type: AppRouter.self, factory: AppRouter.init)
    }

    private func registerPostsViewController() {
        container.register(.unique) { [unowned container] _ -> PostsViewController in
            return PostsViewController()
        }
    }

}
