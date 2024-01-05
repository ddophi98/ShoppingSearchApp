// Copyright © 2023 com.template. All rights reserved.

import Foundation
import Moya
import RxSwift

public protocol SearchDatasource {
    func searchShopping(query: String) -> Single<ShoppingResultDTO>
}

final public class DefaultSearchDatasource: SearchDatasource {
    private let moyaProvider = MoyaProvider<SearchAPI>()
    
    public init() { }
    
    public func searchShopping(query: String) -> Single<ShoppingResultDTO> {
        if let cachedJSON = CacheManager.jsonCache.object(forKey: query) {
            // JSON 자체이기 때문에 디코딩 작업 필요
            return Single.just(cachedJSON)
                .map { try JSONDecoder().decode(ShoppingResultDTO.self, from: $0)}
        } else {
            // 클로저로 캐시 저장 로직 넘겨주기
            return moyaProvider.call(target: .shopping(query: query)) { jsonData in
                if CacheManager.jsonCache.object(forKey: query) == nil {
                    CacheManager.jsonCache.setObject(jsonData, forKey: query)
                }
            }
        }
    }
}
