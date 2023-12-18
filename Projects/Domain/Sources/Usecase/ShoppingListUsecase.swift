// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol ShoppingListUsecase {
    func searchShopping(query: String) -> AnyPublisher<ShoppingResultVO, Error>
    func downloadImage(url: String) -> AnyPublisher<Data, Error>
    func setImageCache(url: String, data: Data)
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
}
