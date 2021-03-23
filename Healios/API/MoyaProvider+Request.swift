//
//  MoyaProvider+Request.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import RxSwift
import Moya

extension Reactive where Base : MoyaProviderType, Base.Target == APISpec {

    func request<T: Codable>(with apiTarget: Base.Target) -> Observable<T> {
        return request(apiTarget)
            .asObservable()
            .flatMapLatest { response -> Observable<T> in
                guard response.statusCode >= 200 && response.statusCode < 300 else {
                    return .error(NetworkError.wrongStatusCode)
                }

                let decoder = JSONDecoder()
                guard let entity = try? decoder.decode(T.self, from: response.data) else {
                    return .error(NetworkError.serializationFailed)
                }

                return .just(entity)
            }
    }

}
