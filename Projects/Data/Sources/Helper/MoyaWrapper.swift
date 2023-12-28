// Copyright © 2023 com.template. All rights reserved.

import Moya
import RxSwift
import RxMoya
import Foundation
import Domain

final class MoyaWrapper<Provider: TargetType>: MoyaProvider<Provider> {
    func call<Value>(target: Provider) -> Single<Value> where Value: Decodable {
        return self.rx.request(target)
            .map(Value.self)
            .catch { error in
                if let moyaError = error as? MoyaError {
                    return .error(moyaError.toCustomError())
                }
                return .error(CustomError.UndefinedError)
            }
    }
    
    func call<Value>(target: Provider, caching: @escaping (Data) -> Void) -> Single<Value> where Value: Decodable {
        return self.rx.request(target)
            .map { response in
                caching(response.data)
                return try response.map(Value.self)
            }
            .catch { error in
                if let moyaError = error as? MoyaError {
                    return .error(moyaError.toCustomError())
                }
                return .error(CustomError.UndefinedError)
            }
    }
}
