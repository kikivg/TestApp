//
//  PostDetailsViewController.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

import UIKit
import RxSwift
import RxDataSources

class PostDetailsViewController: UIViewController {

    typealias DataSource = RxTableViewSectionedReloadDataSource<Section<CommentViewModel>>

    let presenter: PostDetailsPresenter

    var titleLabel: UILabel!
    var bodyLabel: UILabel!
    var usernameLabel: UILabel!
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var commentsTableView: UITableView!
    var headerStackView: UIStackView!
    var userStackView: UIStackView!

    private var dataSource: DataSource!
    private let disposeBag = DisposeBag()

    init(presenter: PostDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Post details"

        buildViews()
        setupCommentsTableView()
        set(viewModel: presenter.viewModel)
    }

    func set(viewModel: PostDetailsViewModel) {
        titleLabel.text = viewModel.title
        bodyLabel.text = viewModel.body
        usernameLabel.text = viewModel.user.username.uppercased()
        nameLabel.text = viewModel.user.name
        emailLabel.text = viewModel.user.email

        Observable.just(viewModel.comments)
            .mapToSection()
            .bind(to: commentsTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    private func setupCommentsTableView() {
        commentsTableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
        commentsTableView.estimatedRowHeight = 50
        commentsTableView.rowHeight = UITableView.automaticDimension
        commentsTableView.allowsSelection = false

        dataSource = DataSource(configureCell: { (_, tableView, indexPath, model) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CommentCell.identifier,
                for: indexPath) as! CommentCell
            cell.set(viewModel: model)
            return cell
        })
    }
    
}
