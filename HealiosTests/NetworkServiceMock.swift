//
//  NetworkServiceMock.swift
//  HealiosTests
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

@testable import Healios
import RxSwift
import Moya

class NetworkServiceMock: Networkable {

    let provider: MoyaProvider<APISpec>

    init() {
        provider = MoyaProvider<APISpec>(
            endpointClosure: Self.customEndpointClosure,
            stubClosure: MoyaProvider<APISpec>.immediatelyStub
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

    static func customEndpointClosure(_ target: APISpec) -> Endpoint {
        return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: { .networkResponse(200, target.testSampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }

}

extension APISpec {

    var testSampleData: Data {
        let bundle = Bundle(for: NetworkServiceMock.self)
        guard let filepath = bundle.path(forResource: path, ofType: "json") else {
            return Data()
        }
        let url = URL(fileURLWithPath: filepath)
        return (try? Data(contentsOf: url)) ?? Data()
    }

}
