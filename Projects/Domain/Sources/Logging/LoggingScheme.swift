// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation

public protocol LoggingScheme {
    var logVersion: Float { get set }
    var eventName: String { get set }
    var screenName: String { get set }
    var logData: Array<(String, String)> { get set }
}
