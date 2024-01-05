// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Domain

public struct LoggingSchemeDTO {
    let scheme: String
}

extension LoggingSchemeVO {
    // CSV 파일에 저장할 수 있는 형태로 바꾸기
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
