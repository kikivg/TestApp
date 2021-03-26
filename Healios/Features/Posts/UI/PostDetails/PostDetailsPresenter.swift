//
//  PostDetailsPresenter.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

class PostDetailsPresenter {

    let viewModel: PostDetailsViewModel

    init(post: PostModel) {
        viewModel = PostDetailsViewModel(from: post)
    }

}
