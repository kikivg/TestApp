//
//  AppRouterProtocol.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

import UIKit

protocol AppRouterProtocol {

    func configureMainInterface(in window: UIWindow?)

    func pushPostDetailsViewController(post: PostModel)

}
