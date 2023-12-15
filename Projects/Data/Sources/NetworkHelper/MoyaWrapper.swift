// Copyright © 2023 com.template. All rights reserved.

import Moya
import Combine
import CombineMoya
import Foundation

final class MoyaWrapper<Provider: TargetType>: MoyaProvider<Provider> {
    func call<Value>(target: Provider) -> AnyPublisher<Value, Error> where Value: Decodable {
        return self.requestPublisher(target)
            .map(Value.self)
            .catch({ moyaError -> Fail in
                if let response = moyaError.response {
                    print(String(decoding: response.data, as: UTF8.self))
                }
                return Fail(error: moyaError)
            })
            .eraseToAnyPublisher()
    }
    
    func call<Value>(target: Provider, caching: @escaping (Data) -> Void) -> AnyPublisher<Value, Error> where Value: Decodable {
        return self.requestPublisher(target)
            .catch({ moyaError -> Fail in
                if let response = moyaError.response {
                    print(String(decoding: response.data, as: UTF8.self))
                }
                return Fail(error: moyaError)
            })
            .tryMap({ response in
                caching(response.data)
                return try response.map(Value.self)
            })
            .eraseToAnyPublisher()
    }
}
