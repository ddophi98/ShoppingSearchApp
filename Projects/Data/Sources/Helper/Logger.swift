// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation

final class Logger {
    // 모든 로그에 공통적으로 들어갈 요소1 (앱이 실행되자마자 값 설정 가능)
    private let appVersion: String = {
        if let info = Bundle.main.infoDictionary,
           let buildNumber = info["CFBundleVersion"] as? String {
            return buildNumber
        }
        return "nil"
    }()
    
    // 모든 로그에 공통적으로 들어갈 요소2 (앱이 실행되자마자 값 설정 가능)
    private let os: String = {
        let os = ProcessInfo.processInfo.operatingSystemVersion
        return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
    }()
    
    // --- CSV 파일에 로그 저장할 때 필요한 기타 변수들 ---
    private let csvFileName = "shoppingSearchAppLog.csv"
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    private let fileManager = FileManager.default
    private var filePath: URL {
        let documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentPath.appendingPathComponent(csvFileName)
        return filePath
    }
    
    func shotLog(_ scheme: String) {
        let time = dateFormatter.string(from: Date())
        let schemeWithAppInfo = "\(time),\(appVersion),\(os)," + scheme
        
        if fileManager.fileExists(atPath: filePath.path) {
            // 파일이 이미 존재한다면 기존 텍스트의 다음줄부터 작성하기
            guard let log = schemeWithAppInfo.data(using: .utf8) else { return }
            if let handle = try? FileHandle(forWritingTo: filePath) {
                handle.seekToEndOfFile()
                handle.write(log)
                handle.closeFile()
            }
        } else {
            // 파일이 없다면 헤더 포함해서 새로 만들기
            let header = "Time,AppVersion,OS,LogVersion,Event,View,Others\n"
            guard let log = (header + schemeWithAppInfo).data(using: .utf8) else { return }
            try? log.write(to: filePath)
        }
    }
}
