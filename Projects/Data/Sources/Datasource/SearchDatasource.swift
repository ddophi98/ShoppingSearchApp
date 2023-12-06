// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol SearchDatasource {
    func searchShopping(query: String, display: Int) -> AnyPublisher<ShoppingResultDTO, Error>
}

final public class DefaultSearchDatasource: SearchDatasource {
    
    public init() { }
    
    private let moyaProvider = MoyaWrapper<SearchAPI>()
    
    public func searchShopping(query: String, display: Int) -> AnyPublisher<ShoppingResultDTO, Error> {
        moyaProvider.call(target: .shopping(query: query, display: display))
    }
}