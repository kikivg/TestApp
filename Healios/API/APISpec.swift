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

}
