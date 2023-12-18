// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation

public class Logger {
    private let appVersion: String
    private let osVersion: String
    
    init(appVersion: String, osVersion: String) {
        self.appVersion = appVersion
        self.osVersion = osVersion
    }
    
    public func shotLog(_ scheme: String) {
        let csvFileName = "shoppingSearchAppLog.csv"
        let fileManager = FileManager.default
        let documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentPath.appendingPathComponent(csvFileName)
        let schemeWithVersion = "appVersion : \(appVersion),osVersion : \(osVersion)," + scheme
        
        
        if fileManager.fileExists(atPath: filePath.path) {
            if let handle = try? FileHandle(forWritingTo: filePath),
               let log = scheme.data(using: .utf8) {
                handle.seekToEndOfFile()
                handle.write(log)
                handle.closeFile()
            }
        } else {
            try? Data().write(to: filePath)
        }
    }
}
