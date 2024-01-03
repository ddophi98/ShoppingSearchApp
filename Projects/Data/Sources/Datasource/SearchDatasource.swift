// Copyright © 2023 com.template. All rights reserved.

import Foundation
import RxSwift

public protocol SearchDatasource {
    func searchShopping(query: String) -> Single<ShoppingResultDTO>
}

final public class DefaultSearchDatasource: SearchDatasource {
    
    public init() { }
    
    private let moyaProvider = MoyaWrapper<SearchAPI>()
    
    public func searchShopping(query: String) -> Single<ShoppingResultDTO> {
        let cacheKey = NSString(string: query)
        if let cachedJSON = CacheManager.jsonCache.object(forKey: cacheKey) {
            return Single.just(Data(referencing: cachedJSON))
                .map { try JSONDecoder().decode(ShoppingResultDTO.self, from: $0)}
        } else {
            return moyaProvider.call(target: .shopping(query: query)) { jsonData in
                let cacheKey = NSString(string: query)
                if CacheManager.jsonCache.object(forKey: cacheKey) == nil {
                    CacheManager.jsonCache.setObject(NSData(data: jsonData), forKey: cacheKey)
                }
            }
        }
    }
}
