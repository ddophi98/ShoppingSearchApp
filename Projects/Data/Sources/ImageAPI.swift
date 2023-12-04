// Copyright © 2023 com.template. All rights reserved.

import Moya
import Foundation

/*
 https://developers.thecatapi.com/view-account/ylX4blBYT9FaoVd6OhvR?report=bOoHBz-8t
 */

enum ImageAPI {
    case catImage
}

extension ImageAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .catImage:
            return URL(string: "https://api.thecatapi.com/")!
        }
    }
    
    var path: String {
        switch self {
        case .catImage:
            return "v1/images/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .catImage:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .catImage:
            let apiKey = Bundle.main.infoDictionary?["CAT_IMAGE_API_KEY"] ?? ""
            return .requestParameters(parameters: [
                "api_key" : apiKey
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .catImage:
            return [:]
        }
    }
}
