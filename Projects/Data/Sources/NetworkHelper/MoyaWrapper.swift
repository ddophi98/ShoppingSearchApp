// Copyright © 2023 com.template. All rights reserved.

import Moya
import Combine
import CombineMoya

class MoyaWrapper<Provider: TargetType>: MoyaProvider<Provider> {
    
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
}
