// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol ImageDatasource {
    func downloadImage(url: String) -> AnyPublisher<Data, Error>
    func setImageCache(url: NSString, data: NSData)
}

final public class DefaultImageDatasource: ImageDatasource {
    
    public init() { }
    
    public func downloadImage(url: String) -> AnyPublisher<Data, Error> {
        let cacheKey = NSString(string: url)
        if let cachedImage = CacheManager.imageCache.object(forKey: cacheKey) {
            return Just(Data(referencing: cachedImage))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return URLSession.shared.call(url: url)
        }
    }
    
    public func setImageCache(url: NSString, data: NSData) {
        CacheManager.imageCache.setObject(data, forKey: url)
    }
}
