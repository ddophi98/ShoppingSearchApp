// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Domain
import Foundation

extension URLSession.DataTaskPublisher.Failure {
    func toCustomError() -> CustomError {
        switch self {
        default:
            return .NetworkError(detail: "URLSession 에러 발생")
        }
    }
}
