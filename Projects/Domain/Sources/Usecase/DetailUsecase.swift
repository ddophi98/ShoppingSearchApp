// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol DetailUsecase {
    func downloadImage(url: String) -> AnyPublisher<Data, Error>
    func setImageCache(url: String, data: Data)
}

final public class DefaultDetailUsecase: DetailUsecase {
    
    private let imageRepository: ImageRepository
    private let loggingRepository: LoggingRepository
    
    public init(imageRepository: ImageRepository, loggingRepository: LoggingRepository) {
        self.imageRepository = imageRepository
        self.loggingRepository = loggingRepository
    }
    
    public func downloadImage(url: String) -> AnyPublisher<Data, Error> {
        imageRepository.downloadImage(url: url)
    }
    
    public func setImageCache(url: String, data: Data) {
        imageRepository.setImageCache(url: url, data: data)
    }
}
