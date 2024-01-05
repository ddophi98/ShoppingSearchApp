// Copyright © 2023 com.template. All rights reserved.

import Domain
import RxSwift

final public class DefaultSearchRepository: SearchRepository {
    private let dataSource: SearchDatasource
    
    public init(dataSource: SearchDatasource) {
        self.dataSource = dataSource
    }
    
    public func searchShopping(query: String) -> Single<ShoppingResultVO> {
        dataSource.searchShopping(query: query)
            .map { $0.toVO() }
    }
}
