//
//  PostsViewController.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 22/03/2021.
//

import UIKit

class PostsViewController: UIViewController {

    var presenter: PostsPresenter!

    convenience init(presenter: PostsPresenter) {
        self.init()
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Posts"
    }


}
