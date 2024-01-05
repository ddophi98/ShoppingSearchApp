// Copyright © 2023 com.template. All rights reserved.

import Domain
import Foundation
import Moya
import RxMoya
import RxSwift

extension MoyaProvider {
    func call<Value>(target: Target, caching: ((Data) -> Void)? = nil) -> Single<Value> where Value: Decodable {
        return self.rx.request(target)
            // .map(Value.self) - 캐싱 처리를 할게 아니라면 이렇게 코드 작성도 가능
            .map { response in
                // 캐싱 클로저가 파라미터로 들어왔다면 실행
                if let caching = caching {
                    caching(response.data)
                }
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
