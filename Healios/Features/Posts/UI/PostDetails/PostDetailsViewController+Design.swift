//
//  PostDetailsViewController+Design.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

import UIKit
import SnapKit

extension PostDetailsViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }

    private func createViews() {
        titleLabel = UILabel()
        bodyLabel = UILabel()
        usernameLabel = UILabel()
        nameLabel = UILabel()
        emailLabel = UILabel()
        commentsTableView = UITableView()
        view.addSubview(commentsTableView)
        headerStackView = UIStackView()
        view.addSubview(headerStackView)
        userStackView = UIStackView()
        view.addSubview(userStackView)

        [titleLabel, bodyLabel].forEach() {
            headerStackView.addArrangedSubview($0)
        }

        [usernameLabel, nameLabel, emailLabel].forEach() {
            userStackView.addArrangedSubview($0)
        }
    }

    private func styleViews() {
        view.backgroundColor = .white

        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        bodyLabel.font = UIFont.systemFont(ofSize: 14)
        bodyLabel.numberOfLines = 0
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 13)
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        emailLabel.font = UIFont.systemFont(ofSize: 12)

        headerStackView.axis = .vertical
        headerStackView.alignment = .leading
        headerStackView.spacing = 10

        userStackView.axis = .vertical
        userStackView.alignment = .leading
        userStackView.spacing = 2

        commentsTableView.backgroundColor = .clear
    }

    private func defineLayout() {
        headerStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }

        userStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
            make.top.equalTo(headerStackView.snp.bottom).offset(10)
        }

        commentsTableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(userStackView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
    }

}
