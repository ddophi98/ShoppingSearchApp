// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol BasketUsecase {
    func getBasketContents() -> AnyPublisher<[ServerDrivenContentVO], Error>
    func downloadImage(url: String) -> AnyPublisher<Data, Error>
    func setImageCache(url: String, data: Data)
}

final public class DefaultBasketUsecase: BasketUsecase {
    
    private let serverDrivenRepository: ServerDrivenRepository
    private let imageRepository: ImageRepository
    
    public init(serverDrivenRepository: ServerDrivenRepository, imageRepository: ImageRepository) {
        self.serverDrivenRepository = serverDrivenRepository
        self.imageRepository = imageRepository
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
}
