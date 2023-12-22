// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation

public enum CustomError: Error {
    case NetworkError(detail: String)
    case UndefinedError
}
