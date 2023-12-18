// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation

public protocol LoggingScheme {
    var logVersion: Float { get set }
    var eventName: String { get set }
    var screenName: String { get set }
    var logData: [String: String] { get set }
}

extension LoggingScheme {
    public func toDTO() -> String {
        var logString = ""
        logString += "\(self.logVersion),\(self.eventName),\(self.screenName),"
        for (idx, (key, value)) in self.logData.enumerated() {
            logString += "\(key):\(value)"
            if idx != self.logData.count-1 {
                logString += ","
            }
        }
        logString += "\n"
        return logString
    }
}
