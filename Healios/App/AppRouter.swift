//
//  AppRouter.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 22/03/2021.
//

import UIKit
import Dip

class AppRouter {

    private var navigationController: UINavigationController?

    private let postsFactory = Factory<PostsViewController>()

    func configureMainInterface(in window: UIWindow?) {
        let postsViewController = postsFactory.create()
        navigationController = UINavigationController(rootViewController: postsViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func pushPostDetailsViewController(post: PostModel) {
        
    }

}
