// Copyright © 2023 com.template. All rights reserved.

import Foundation
import RxSwift

public protocol ImageDatasource {
    func downloadImage(url: String) -> Single<Data>
    func setImageCache(url: NSString, data: NSData)
}

final public class DefaultImageDatasource: ImageDatasource {
    
    public init() { }
    
    public func downloadImage(url: String) -> Single<Data> {
        let cacheKey = NSString(string: url)
        if let cachedImage = CacheManager.imageCache.object(forKey: cacheKey) {
            return Single.just(Data(referencing: cachedImage))
        } else {
            return URLSession.shared.call(url: url)
        }
    }
    
    public func setImageCache(url: NSString, data: NSData) {
        let cacheKey = NSString(string: url)
        if CacheManager.imageCache.object(forKey: cacheKey) == nil {
            CacheManager.imageCache.setObject(data, forKey: url)
        }
    }
}
