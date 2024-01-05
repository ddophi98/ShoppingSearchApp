// Copyright © 2023 com.template. All rights reserved.

import Foundation
import RxSwift
import Domain

extension URLSession {
    func call(url: String, caching: ((Data) -> Void)? = nil) -> Single<Data> {
        Single.create { single in
            guard let url = URL(string: url) else {
                single(.failure(CustomError.NetworkError(detail: "URLSession 에러 발생\n[주소가 잘못됐습니다.]")))
                return Disposables.create()
            }
            let task = self.dataTask(with: url) { data, response, error in
                if let data = data {
                    // 캐싱 클로저가 파라미터로 들어왔다면 실행
                    if let caching = caching {
                        caching(data)
                    }
                    single(.success(data))
                } else if let error = error {
                    single(.failure(CustomError.NetworkError(detail: "URLSession 에러 발생\n[\(error.localizedDescription)]")))
                }
            }
            task.resume()
            return Disposables.create()
        }
    }
}
