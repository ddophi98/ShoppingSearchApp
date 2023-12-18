// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol ShoppingListUsecase {
    func searchShopping(query: String) -> AnyPublisher<ShoppingResultVO, Error>
    func downloadImage(url: String) -> AnyPublisher<Data, Error>
    func setImageCache(url: String, data: Data)
    
    // --- logging ---
    func loggingViewAppeared()
    func loggingProductSearched(query: String)
    func loggingProductTapped(productName: String, productPrice: Int, productPosition: String, productIndex: Int)
}

final public class DefaultShoppingResultUsecase: ShoppingListUsecase {
    private let searchRepository: SearchRepository
    private let imageRepository: ImageRepository
    private let loggingRepository: LoggingRepository
    
    public init(searchRepository: SearchRepository, imageRepository: ImageRepository, loggingRepository: LoggingRepository) {
        self.searchRepository = searchRepository
        self.imageRepository = imageRepository
        self.loggingRepository = loggingRepository
    }
    
    public func searchShopping(query: String) -> AnyPublisher<ShoppingResultVO, Error> {
        searchRepository.searchShopping(query: query)
    }
    
    public func downloadImage(url: String) -> AnyPublisher<Data, Error> {
        imageRepository.downloadImage(url: url)
    }
    
    public func setImageCache(url: String, data: Data) {
        imageRepository.setImageCache(url: url, data: data)
    }
    
    // --- logging ---
    public func loggingViewAppeared() {
        let scheme = ShoppingListViewAppeared.Builder().build()
        loggingRepository.shotLog(scheme)
    }
    
    public func loggingProductSearched(query: String) {
        let scheme = ShoppingProductSearched.Builder()
            .setQuery(query)
            .build()
        loggingRepository.shotLog(scheme)
    }
    
    public func loggingProductTapped(productName: String, productPrice: Int, productPosition: String, productIndex: Int) {
        let scheme = ShoppingProductTapped.Builder()
            .setProductName(productName)
            .setProductPrice(productPrice)
            .setProductPosition(productPosition)
            .setProductIndex(productIndex)
            .build()
        loggingRepository.shotLog(scheme)
    }
}
