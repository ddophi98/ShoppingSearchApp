// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol RandomCatUsecase {
    func loadCatImage() -> AnyPublisher<[CatImageVO], Error>
    func download(url: String) -> AnyPublisher<Data, Error>
}

public final class DefaultRandomCatUsecase: RandomCatUsecase {
    private let repository: ImageRepository
    
    public init(repository: ImageRepository) {
        self.repository = repository
    }
    
    public func loadCatImage() -> AnyPublisher<[CatImageVO], Error> {
        repository.loadCatImage()
    }
    
    public func download(url: String) -> AnyPublisher<Data, Error> {
        repository.download(url: url)
    }
}
