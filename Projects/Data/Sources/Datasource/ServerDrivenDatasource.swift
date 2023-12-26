// Copyright © 2023 com.template. All rights reserved.

import Foundation
import RxSwift

public protocol ServerDrivenDatasource {
    func getBasketContents() -> Single<ServerDrivenDTO>
}

final public class DefaultServerDrivenDatasource: ServerDrivenDatasource {
    
    public init() { }
    
    private let moyaProvider = MoyaWrapper<ServerDrivenAPI>()
    
    public func getBasketContents() -> Single<ServerDrivenDTO> {
        moyaProvider.call(target: .basket)
    }
}
