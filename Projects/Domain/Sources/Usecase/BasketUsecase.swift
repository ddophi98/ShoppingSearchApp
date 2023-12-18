// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol BasketUsecase {
    func getBasketContents() -> AnyPublisher<[ServerDrivenContentVO], Error>
    func downloadImage(url: String) -> AnyPublisher<Data, Error>
    func setImageCache(url: String, data: Data)
    
    // --- logging ---
    func loggingViewAppeared()
}

final public class DefaultBasketUsecase: BasketUsecase {
    
    private let serverDrivenRepository: ServerDrivenRepository
    private let imageRepository: ImageRepository
    private let loggingRepository: LoggingRepository
    
    public init(serverDrivenRepository: ServerDrivenRepository, imageRepository: ImageRepository, loggingRepository: LoggingRepository) {
        self.serverDrivenRepository = serverDrivenRepository
        self.imageRepository = imageRepository
        self.loggingRepository = loggingRepository
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
    
    // --- logging ---
    public func loggingViewAppeared() {
        let scheme = BasketViewAppeared.Builder().build()
        loggingRepository.shotLog(scheme)
    }
}
