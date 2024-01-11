// Copyright © 2024 com.shoppingSearch. All rights reserved.

import RxSwift

final class MockSearchRepository: SearchRepository {
    private var searchShoppingResult: ShoppingResultVO?
    
    func setSearchShoppingResult(_ searchShoppingResult: ShoppingResultVO?) {
        self.searchShoppingResult = searchShoppingResult
    }
    
    func searchShopping(query: String) -> Single<ShoppingResultVO> {
        if let result = searchShoppingResult {
            Single.just(result)
        } else {
            Single.just(ShoppingResultVO(
                lastBuildDate: "",
                total: -1,
                start: -1,
                display: -1,
                items: [])
            )
        }
    }
}
