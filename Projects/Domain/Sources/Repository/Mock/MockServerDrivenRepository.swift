// Copyright © 2024 com.shoppingSearch. All rights reserved.

import RxSwift

final class MockServerDrivenRepository: ServerDrivenRepository {
    private var getBasketContentsResult: [ServerDrivenContentVO]?
    
    func setGetBasketContents(_ getBasketContentsResult: [ServerDrivenContentVO]?) {
        self.getBasketContentsResult = getBasketContentsResult
    }
    
    func getBasketContents() -> Single<[ServerDrivenContentVO]> {
        if let result = getBasketContentsResult {
            Single.just(result)
        } else {
            Single.just([])
        }
    }
}
