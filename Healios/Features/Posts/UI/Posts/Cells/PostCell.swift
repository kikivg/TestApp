//
//  PostCell.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

import UIKit
import SnapKit

class PostCell: UITableViewCell {

    private var titleLabel: UILabel!
    private var bodyLabel: UILabel!
    private var usernameLabel: UILabel!
    private var commentsCountLabel: UILabel!
    private var stackView: UIStackView!
    private var bottomStackview: UIStackView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildViews()
    }

    func set(viewModel: PostListViewModel) {
        titleLabel.text = viewModel.title
        bodyLabel.text = viewModel.body
        usernameLabel.text = viewModel.userNickname.uppercased()
        commentsCountLabel.text = "Num. of comm.: \(viewModel.numberOfComments)"
    }

}

extension PostCell {

    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }

    private func createViews() {
        titleLabel = UILabel()
        bodyLabel = UILabel()
        usernameLabel = UILabel()
        commentsCountLabel = UILabel()

        stackView = UIStackView()
        addSubview(stackView)

        bottomStackview = UIStackView()
        addSubview(bottomStackview)

        [usernameLabel, commentsCountLabel].forEach() {
            bottomStackview.addArrangedSubview($0)
        }

        [titleLabel, bodyLabel, bottomStackview].forEach() {
            stackView.addArrangedSubview($0)
        }
    }

    private func styleViews() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        bodyLabel.font = UIFont.systemFont(ofSize: 11)
        bodyLabel.lineBreakMode = .byTruncatingTail
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 10)
        commentsCountLabel.font = UIFont.boldSystemFont(ofSize: 10)

        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 3

        bottomStackview.axis = .horizontal
        bottomStackview.alignment = .lastBaseline
        bottomStackview.distribution = .equalCentering
    }

    private func defineLayout() {
        stackView.snp.makeConstraints { make in
            make.margins.equalToSuperview()
        }

        bottomStackview.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
    }

}
