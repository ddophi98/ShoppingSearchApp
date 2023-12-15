// Copyright © 2023 com.template. All rights reserved.

import Moya
import Foundation

/*
 https://developers.naver.com/docs/serviceapi/search/shopping/shopping.md#%EC%87%BC%ED%95%91-%EA%B2%80%EC%83%89-%EA%B2%B0%EA%B3%BC-%EC%A1%B0%ED%9A%8C
 */

enum SearchAPI {
    case shopping(query: String)
}

extension SearchAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .shopping:
            return URL(string: "https://openapi.naver.com/")!
        }
    }
    
    var path: String {
        switch self {
        case .shopping:
            return "v1/search/shop.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .shopping:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .shopping(let query):
            return .requestParameters(parameters: [
                "query" : query,
                "display": 10
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .shopping:
            let clientId = Bundle.main.infoDictionary?["NAVER_CLIENT_ID"] ?? ""
            let clientSecret = Bundle.main.infoDictionary?["NAVER_CLIENT_SECRET"] ?? ""
            return [
                "X-Naver-Client-Id" : "\(clientId)",
                "X-Naver-Client-Secret" : "\(clientSecret)"
            ]
        }
    }
}
