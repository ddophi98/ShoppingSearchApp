// Copyright © 2023 com.template. All rights reserved.

import Combine

public protocol ServerDrivenRepository {
    func getBasketContents() -> AnyPublisher<[ServerDrivenContentVO], Error>
}
