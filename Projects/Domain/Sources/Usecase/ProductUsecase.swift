// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol ProductUsecase {
    func searchShopping(query: String) -> AnyPublisher<ShoppingResultVO, Error>
    func getBasketContents() -> AnyPublisher<[ServerDrivenContentVO], Error>
    func downloadImage(url: String) -> AnyPublisher<Data, Error>
    func setImageCache(url: String, data: Data)
}

final public class DefaultProductUsecase: ProductUsecase {
    
    private let serverDrivenRepository: ServerDrivenRepository
    private let imageRepository: ImageRepository
    private let searchRepository: SearchRepository
    
    public init(serverDrivenRepository: ServerDrivenRepository, imageRepository: ImageRepository, searchRepository: SearchRepository) {
        self.serverDrivenRepository = serverDrivenRepository
        self.imageRepository = imageRepository
        self.searchRepository = searchRepository
    }
    
    public func getBasketContents() -> AnyPublisher<[ServerDrivenContentVO], Error> {
        serverDrivenRepository.getBasketContents()
    }
    
    public func downloadImage(url: String) -> AnyPublisher<Data, Error> {
        imageRepository.downloadImage(url: url)
    }
    
    public func setImageCache(url: String, data: Data) {
        imageRepository.setImageCache(url: url, data: data)
    }
    
    public func searchShopping(query: String) -> AnyPublisher<ShoppingResultVO, Error> {
        searchRepository.searchShopping(query: query)
    }
}
