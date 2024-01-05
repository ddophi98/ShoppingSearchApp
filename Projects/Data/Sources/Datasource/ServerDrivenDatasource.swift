// Copyright © 2023 com.template. All rights reserved.

import Moya
import RxSwift

public protocol ServerDrivenDatasource {
    func getBasketContents() -> Single<ServerDrivenDTO>
}

final public class DefaultServerDrivenDatasource: ServerDrivenDatasource {
    private let moyaProvider = MoyaProvider<ServerDrivenAPI>()
    
    public init() { }
    
    public func getBasketContents() -> Single<ServerDrivenDTO> {
        moyaProvider.call(target: .basket)
    }
}
