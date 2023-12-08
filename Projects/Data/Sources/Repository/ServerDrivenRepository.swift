// Copyright © 2023 com.template. All rights reserved.

import Combine
import Domain

final public class DefaultServerDrivenRepository: ServerDrivenRepository {
    private let datasource: ServerDrivenDatasource
    
    public init(datasource: ServerDrivenDatasource) {
        self.datasource = datasource
    }
    
    public func getBasketContents() -> AnyPublisher<[ServerDrivenContentVO], Error> {
        datasource.getBasketContents()
            .map { $0.blocks.compactMap { $0.content?.toVO() }}
            .eraseToAnyPublisher()
    }
}
