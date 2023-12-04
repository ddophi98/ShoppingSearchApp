// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol ShoppingListUsecase {
    func searchShopping(query: String, display: Int) -> AnyPublisher<ShoppingResultVO, Error>
    func downloadImage(url: String) -> AnyPublisher<Data, Error>
}

public final class DefaultShoppingResultUsecase: ShoppingListUsecase {
    private let repository: SearchRepository
    
    public init(repository: SearchRepository) {
        self.repository = repository
    }
    
    public func searchShopping(query: String, display: Int) -> AnyPublisher<ShoppingResultVO, Error> {
        repository.searchShopping(query: query, display: display)
    }
    
    public func downloadImage(url: String) -> AnyPublisher<Data, Error> {
        repository.downloadImage(url: url)
    }
}
