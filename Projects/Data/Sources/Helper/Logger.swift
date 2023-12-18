// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation

public class Logger {
    
    private let appVersion: String = {
        if let info: [String: Any] = Bundle.main.infoDictionary,
           let buildNumber: String
            = info["CFBundleVersion"] as? String {
            return buildNumber
        }
        return "nil"
    }()
    
    private let os: String = {
        let os = ProcessInfo.processInfo.operatingSystemVersion
        return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
    }()
    
    public func shotLog(_ scheme: String) {
        let csvFileName = "shoppingSearchAppLog.csv"
        let fileManager = FileManager.default
        let documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentPath.appendingPathComponent(csvFileName)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let time = dateFormatter.string(from: Date())
        
        let schemeWithAppInfo = "\(time),\(appVersion),\(os)," + scheme
        
        if fileManager.fileExists(atPath: filePath.path) {
            guard let log = schemeWithAppInfo.data(using: .utf8) else { return }
            if let handle = try? FileHandle(forWritingTo: filePath) {
                handle.seekToEndOfFile()
                handle.write(log)
                handle.closeFile()
            }
        } else {
            let header = "Time,AppVersion,OS,LogVersion,Event,View,Others\n"
            guard let log = (header + schemeWithAppInfo).data(using: .utf8) else { return }
            try? log.write(to: filePath)
        }
    }
}
