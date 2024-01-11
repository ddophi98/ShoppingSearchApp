// Copyright © 2024 com.shoppingSearch. All rights reserved.

import Foundation
import RxSwift

final public class MockProductUsecase: ProductUsecase {
    public init() { }
    
    private var searchShoppingResult: [ShoppingListSection]?
    private var getBasketContentsResult: [ServerDrivenContentVO]?
    private var downloadImageResult: Data?
    
    public func setSearchShoppingResult(_ searchShoppingResult: [ShoppingListSection]?) {
        self.searchShoppingResult = searchShoppingResult
    }
    
    public func setGetBasketContentsResult(_ getBasketContentsResult: [ServerDrivenContentVO]?) {
        self.getBasketContentsResult = getBasketContentsResult
    }
    
    public func setdownloadImageResult(_ downloadImageResult: Data?) {
        self.downloadImageResult = downloadImageResult
    }
    
    public func searchShopping(query: String) -> Single<[ShoppingListSection]> {
        if let result = searchShoppingResult {
            Single.just(result)
        } else {
            Single.just([])
        }
    }
    
    public func getBasketContents() -> Single<[ServerDrivenContentVO]> {
        if let result = getBasketContentsResult {
            Single.just(result)
        } else {
            Single.just([])
        }
    }
    
    public func downloadImage(url: String) -> Single<Data> {
        if let result = downloadImageResult {
            Single.just(result)
        } else {
            Single.just(Data())
        }
    }
}
