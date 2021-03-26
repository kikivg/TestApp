//
//  AppRouter.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 22/03/2021.
//

import UIKit
import Dip

class AppRouter: AppRouterProtocol {

    private var navigationController: UINavigationController?

    private let postsFactory = Factory<PostsViewController>()
    private let postDetailsFactory = Factory<PostDetailsViewController>()

    func configureMainInterface(in window: UIWindow?) {
        let postsViewController = postsFactory.create()
        navigationController = UINavigationController(rootViewController: postsViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func pushPostDetailsViewController(post: PostModel) {
        let postDetailsViewControlelr = postDetailsFactory.create(withArguments: post)
        navigationController?.pushViewController(postDetailsViewControlelr, animated: true)
    }

}
