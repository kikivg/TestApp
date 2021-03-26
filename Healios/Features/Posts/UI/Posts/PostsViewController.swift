//
//  PostsViewController.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 22/03/2021.
//

import UIKit
import RxSwift
import RxDataSources

class PostsViewController: UIViewController {

    typealias DataSource = RxTableViewSectionedReloadDataSource<Section<PostListViewModel>>

    var presenter: PostsPresenter!

    var tableView: UITableView!

    private var dataSource: DataSource!
    private let disposeBag = DisposeBag()

    convenience init(presenter: PostsPresenter) {
        self.init()
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Posts"

        buildViews()
        setupTableView()
        bindPresenter()
        bindActions()
    }

    private func setupTableView() {
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension

        dataSource = DataSource(configureCell: { (_, tableView, indexPath, model) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PostCell.identifier,
                for: indexPath) as! PostCell
            cell.set(viewModel: model)
            return cell
        })
    }

    private func bindPresenter() {
        presenter.postViewModels
            .mapToSection()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        let notificationObservable = NotificationCenter.default.rx
            .notification(UIApplication.willEnterForegroundNotification)
            .map { _ in () }

        Observable.merge(.just(()), notificationObservable)
            .flatMapLatest { [weak self] _ -> Observable<Bool> in
                guard let self = self else { return .empty() }
                return self.presenter.postsExist
            }
            .filter { !$0 }
            .flatMapLatest { [weak self] _ -> Observable<Never> in
                guard let self = self else { return .empty() }
                return self.presenter.refreshPosts().asObservable()
            }
            .subscribe()
            .disposed(by: disposeBag)
    }

    private func bindActions() {
        Observable.zip(tableView.rx.modelSelected(PostListViewModel.self), tableView.rx.itemSelected)
            .subscribe(onNext: { [weak self] postModel, indexPath in
                self?.presenter.postSelected(postId: postModel.id)
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }

}
