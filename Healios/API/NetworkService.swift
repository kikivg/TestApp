//
//  NetworkService.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import Moya
import RxSwift

enum NetworkError: Error {

    case wrongStatusCode
    case serializationFailed

}

class NetworkService: Networkable {

    let provider: MoyaProvider<APISpec>

    init() {
        provider = MoyaProvider<APISpec>(
            callbackQueue: DispatchQueue.global(qos: .background)
        )
    }

    func getPosts() -> Observable<[PostAPIModel]> {
        provider.rx.request(with: .posts)
    }

    func getUsers() -> Observable<[UserAPIModel]> {
        provider.rx.request(with: .users)
    }

    func getComments() -> Observable<[CommentAPIModel]> {
        provider.rx.request(with: .comments)
    }

}
