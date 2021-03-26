//
//  APISpec.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 23/03/2021.
//

import Moya

enum APISpec: String, TargetType {

    case posts
    case users
    case comments

    var path: String  {
        rawValue
    }

    var baseURL: URL {
        URL(string: "http://jsonplaceholder.typicode.com")!
    }

    var method: Method {
        .get
    }

    var task: Task {
        .requestPlain
    }

    var headers: [String : String]? {
        [:]
    }

    var sampleData: Data {
        Data()
    }

//    var sampleData: Data {
//        let bundle = Bundle(for: NetworkServiceMock.self)
//        guard let filepath = bundle.path(forResource: path, ofType: "json") else {
//            return Data()
//        }
//        let url = URL(fileURLWithPath: filepath)
//        return (try? Data(contentsOf: url)) ?? Data()
//    }

}
