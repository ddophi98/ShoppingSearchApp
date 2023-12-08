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
            return URL(string: " https://gist.githubusercontent.com/")!
        }
    }
    
    var path: String {
        switch self {
        case .basket:
            return "ddophi98/14535628aa282fb22a1284d3bebc5a83/raw/a7bc11eeb7f8ad1f5b8e04cdb2a887bac29f5cae/JsonForServerDrivenUI"
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
