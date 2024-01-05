// Copyright © 2023 com.template. All rights reserved.

import Foundation
import RxSwift

public protocol ImageDatasource {
    func downloadImage(url: String) -> Single<Data>
}

final public class DefaultImageDatasource: ImageDatasource {
    public init() { }
    
    public func downloadImage(url: String) -> Single<Data> {
        if let cachedImage = CacheManager.imageCache.object(forKey: url) {
            return Single.just(cachedImage)
        } else {
            // 클로저로 캐시 저장 로직 넘겨주기
            return URLSession.shared.call(url: url) { imageData in
                if CacheManager.imageCache.object(forKey: url) == nil {
                    CacheManager.imageCache.setObject(imageData, forKey: url)
                }
            }
        }
    }
}
