// Copyright © 2023 com.template. All rights reserved.

import Moya
import Foundation

enum ServerDrivenAPI {
    case basket
}

extension ServerDrivenAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .basket:
            return URL(string: "https://gist.githubusercontent.com/")!
        }
    }
    
    var path: String {
        switch self {
        case .basket:
            return "ddophi98/14535628aa282fb22a1284d3bebc5a83/raw/daa6bd83de74f176b9956458c069a11db7f81bf8/JsonForServerDrivenUI"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .basket:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .basket:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .basket:
            return [:]
        }
    }
}