// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation

public protocol LoggingScheme: Encodable {
    var eventName: String { get set }
    var screenName: String { get set }
    var logVersion: Int { get set }
    var logData: [String: String] { get set }
}

public class Logger {
    private let appVersion: String
    private let os: String
    
    init(appVersion: String, os: String) {
        self.appVersion = appVersion
        self.os = os
    }
    
    public func shotLog(_ scheme: LoggingScheme) {
        let csvFileName = "shoppingSearchAppLog.csv"
        let fileManager = FileManager.default
        let documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentPath.appendingPathComponent(csvFileName)
        let logString = makeLogString(scheme)
        
        if fileManager.fileExists(atPath: filePath.path) {
            if let handle = try? FileHandle(forWritingTo: filePath),
               let log = logString.data(using: .utf8) {
                handle.seekToEndOfFile()
                handle.write(log)
                handle.closeFile()
            }
        } else {
            try? Data().write(to: filePath)
        }
    }
    
    private func makeLogString(_ scheme: LoggingScheme) -> String {
        var logString = ""
        logString += "appVersion : \(appVersion),"
        logString += "os : \(os),"
        logString += "eventName : \(scheme.eventName),"
        logString += "screenName : \(scheme.screenName),"
        logString += "logVersion : \(scheme.logVersion),"
        for (key, value) in scheme.logData {
            logString += "\(key) : \(value),"
        }
        return logString
    }
}
