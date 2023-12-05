// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol ShoppingListUsecase {
    func searchShopping(query: String, display: Int) -> AnyPublisher<ShoppingResultVO, Error>
    func downloadImage(url: String) -> AnyPublisher<Data, Error>
}

public final class DefaultShoppingResultUsecase: ShoppingListUsecase {
    private let searchRepository: SearchRepository
    private let imageRepository: ImageRepository
    
    public init(searchRepository: SearchRepository, imageRepository: ImageRepository) {
        self.searchRepository = searchRepository
        self.imageRepository = imageRepository
    }
    
    public func searchShopping(query: String, display: Int) -> AnyPublisher<ShoppingResultVO, Error> {
        searchRepository.searchShopping(query: query, display: display)
    }
    
    public func downloadImage(url: String) -> AnyPublisher<Data, Error> {
        imageRepository.downloadImage(url: url)
    }
}
