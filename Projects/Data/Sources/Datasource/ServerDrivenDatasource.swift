// Copyright © 2023 com.template. All rights reserved.

import Foundation
import Combine

public protocol ServerDrivenDatasource {
    func getBasketContents() -> AnyPublisher<ServerDrivenDTO, Error>
}

final public class DefaultServerDrivenDatasource: ServerDrivenDatasource {
    
    public init() { }
    
    private let moyaProvider = MoyaWrapper<ServerDrivenAPI>()
    
    public func getBasketContents() -> AnyPublisher<ServerDrivenDTO, Error> {
        moyaProvider.call(target: .basket)
    }
}
