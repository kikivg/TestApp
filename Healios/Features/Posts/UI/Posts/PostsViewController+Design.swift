//
//  PostsViewController+Design.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

import UIKit
import SnapKit

extension PostsViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }

    private func createViews() {
        tableView = UITableView()
        view.addSubview(tableView)
    }

    private func styleViews() {
        view.backgroundColor = .white
        tableView.backgroundColor = .clear
    }

    private func defineLayout() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }

}
