//
//  CommentCell.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

import UIKit

class CommentCell: UITableViewCell {

    private var nameLabel: UILabel!
    private var bodyLabel: UILabel!
    private var emailLabel: UILabel!
    private var stackView: UIStackView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildViews()
    }

    func set(viewModel: CommentViewModel) {
        nameLabel.text = viewModel.name
        bodyLabel.text = viewModel.body
        emailLabel.text = viewModel.email
    }

}

extension CommentCell {

    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }

    private func createViews() {
        nameLabel = UILabel()
        bodyLabel = UILabel()
        emailLabel = UILabel()

        stackView = UIStackView()
        addSubview(stackView)

        [emailLabel, nameLabel, bodyLabel].forEach() {
            stackView.addArrangedSubview($0)
        }
    }

    private func styleViews() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        nameLabel.numberOfLines = 0
        bodyLabel.font = UIFont.systemFont(ofSize: 11)
        bodyLabel.numberOfLines = 0
        emailLabel.font = UIFont.boldSystemFont(ofSize: 14)

        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
    }

    private func defineLayout() {
        stackView.snp.makeConstraints { make in
            make.margins.equalToSuperview()
        }
    }

}
