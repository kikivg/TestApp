//
//  PostDetailsViewController.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

import UIKit

class PostDetailsViewController: UIViewController {

    var presenter: PostDetailsPresenter!

    convenience init(presenter: PostDetailsPresenter) {
        self.init()
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Post details"

        buildViews()
        set(viewModel: presenter.viewModel)
    }

    func set(viewModel: PostDetailsViewModel) {
        
    }
    
}
