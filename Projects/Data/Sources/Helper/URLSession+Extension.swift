// Copyright © 2023 com.template. All rights reserved.

import Foundation
import RxSwift

extension URLSession {
    func call(url: String) -> Single<Data> {
        Single.create { single in
            let task = self.dataTask(with: URL(string: url)!) { data, response, error in
                if let data = data {
                    single(.success(data))
                } else if let error = error {
                    single(.failure(error))
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
