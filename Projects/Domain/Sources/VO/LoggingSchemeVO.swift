// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation

public protocol LoggingSchemeVO {
    var eventName: String { get set }
    var screenName: String { get set }
    var logVersion: Int { get set }
    var logData: [String: String] { get set }
}

extension LoggingSchemeVO {
    public func toDTO() -> String {
        var logString = ""
        logString += "eventName : \(self.eventName),"
        logString += "screenName : \(self.screenName),"
        logString += "logVersion : \(self.logVersion),"
        for (key, value) in self.logData {
            logString += "\(key) : \(value),"
        }
        return logString
    }
}
