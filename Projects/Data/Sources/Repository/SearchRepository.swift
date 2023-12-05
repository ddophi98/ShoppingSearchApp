// Copyright © 2023 com.template. All rights reserved.

import Combine
import Domain
import Foundation

final public class DefaultSearchRepository: SearchRepository {
    private let dataSource: SearchDatasource
    
    public init(dataSource: SearchDatasource) {
        self.dataSource = dataSource
    }
    
    public func searchShopping(query: String, display: Int) -> AnyPublisher<ShoppingResultVO, Error> {
        dataSource.searchShopping(query: query, display: display)
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
}
