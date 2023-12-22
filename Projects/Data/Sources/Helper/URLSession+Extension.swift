// Copyright © 2023 com.template. All rights reserved.

import Foundation
import Combine

extension URLSession {
    func call(url: String) -> AnyPublisher<Data, Error> {
        return self.dataTaskPublisher(for: URL(string: url)!)
            .map { $0.data }
            .mapError { $0.toCustomError() }
            .eraseToAnyPublisher()
    }
}
