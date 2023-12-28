// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation
import Domain

public struct LoggingSchemeDTO {
    let scheme: String
}

extension LoggingScheme {
    func toDTO() -> LoggingSchemeDTO {
        var logString = ""
        logString += "\(self.logVersion),\(self.eventName),\(self.screenName),"
        for (idx, (key, value)) in self.logData.enumerated() {
            logString += "[\(key)] \(value)"
            if idx != self.logData.count-1 {
                logString += ","
            }
        }
        logString += "\n"
        return LoggingSchemeDTO(scheme: logString)
    }
}
