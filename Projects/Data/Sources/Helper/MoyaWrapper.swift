// Copyright © 2023 com.template. All rights reserved.

import Moya
import RxSwift
import RxMoya
import Foundation

final class MoyaWrapper<Provider: TargetType>: MoyaProvider<Provider> {
    func call<Value>(target: Provider) -> Single<Value> where Value: Decodable {
        return self.rx.request(target)
            .map(Value.self)
    }
    
    func call<Value>(target: Provider, caching: @escaping (Data) -> Void) -> Single<Value> where Value: Decodable {
        return self.rx.request(target)
            .map { response in
                caching(response.data)
                return try response.map(Value.self)
            }
    }
}
