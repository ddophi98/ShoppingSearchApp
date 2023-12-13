// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol DetailUsecase {
    func downloadImage(url: String) -> AnyPublisher<Data, Error>
}

final public class DefaultDetailUsecase: DetailUsecase {
    
    private let repository: ImageRepository
    
    public init(repository: ImageRepository) {
        self.repository = repository
    }
    
    public func downloadImage(url: String) -> AnyPublisher<Data, Error> {
        repository.downloadImage(url: url)
    }
}
