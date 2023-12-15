// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol SearchDatasource {
    func searchShopping(query: String) -> AnyPublisher<ShoppingResultDTO, Error>
}

final public class DefaultSearchDatasource: SearchDatasource {
    
    public init() { }
    
    private let moyaProvider = MoyaWrapper<SearchAPI>()
    
    public func searchShopping(query: String) -> AnyPublisher<ShoppingResultDTO, Error> {
        let cacheKey = NSString(string: query)
        if let cachedJSON = CacheManager.jsonCache.object(forKey: cacheKey) {
            return Just(Data(referencing: cachedJSON))
                .decode(type: ShoppingResultDTO.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        } else {
            return moyaProvider.call(target: .shopping(query: query)) { jsonData in
                CacheManager.jsonCache.setObject(NSData(data: jsonData), forKey: cacheKey)
            }
        }
    }
}
