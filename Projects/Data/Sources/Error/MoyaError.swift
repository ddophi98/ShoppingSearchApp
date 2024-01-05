// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Moya
import Domain

extension MoyaError {
    func toCustomError() -> CustomError {
        switch self {
        
        // 필요하다면 Moya에서 발생하는 에러를 어떤 커스텀 에러로 변환할건지 설정 가능
        /*
        case .imageMapping(let response):
            <#code#>
        case .jsonMapping(let response):
            <#code#>
        case .stringMapping(let response):
            <#code#>
        case .objectMapping(let error, let response):
            <#code#>
        case .encodableMapping(let error):
            <#code#>
        case .statusCode(let response):
            <#code#>
        case .underlying(let error, let response):
            <#code#>
        case .requestMapping(let string):
            <#code#>
        case .parameterEncoding(let error):
            <#code#>
        */
            
        default:
            return .NetworkError(detail: "Moya 에러 발생\n[\(self.localizedDescription)]")
        }
    }
}
