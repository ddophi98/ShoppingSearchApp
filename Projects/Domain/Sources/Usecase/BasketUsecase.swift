// Copyright © 2023 com.template. All rights reserved.

import Combine

public protocol BasketUsecase {
    func getBasketContents() -> AnyPublisher<[ServerDrivenContentVO], Error>
}

final public class DefaultBasketUsecase: BasketUsecase {
    
    private let repository: ServerDrivenRepository
    
    public init(repository: ServerDrivenRepository) {
        self.repository = repository
    }
    
    public func getBasketContents() -> AnyPublisher<[ServerDrivenContentVO], Error> {
        repository.getBasketContents()
    }
}
