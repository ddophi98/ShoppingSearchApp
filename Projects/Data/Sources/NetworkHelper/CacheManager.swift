// Copyright © 2023 com.template. All rights reserved.

import Foundation

final class CacheManager {
    static let imageCache = NSCache<NSString, NSData>()
    static let jsonCache = NSCache<NSString, NSData>()
    private init() { }
}
