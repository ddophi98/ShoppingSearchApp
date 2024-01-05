// Copyright © 2023 com.template. All rights reserved.

import Foundation

final class CacheManager {
    static let imageCache = NSCache<NSString, NSData>()
    static let jsonCache = NSCache<NSString, NSData>()
    private init() { }
}

// Data, String 타입을 일일이 NSData, NSString 타입으로 변환하기 번거로워서 만든 extension
extension NSCache<NSString, NSData> {
    func setObject(_ data: Data, forKey key: String) {
        self.setObject(NSData(data: data), forKey: NSString(string: key))
    }
    
    func object(forKey key: String) -> Data? {
        guard let nsData = self.object(forKey: NSString(string: key)) else { return nil }
        return Data(referencing: nsData)
    }
}
