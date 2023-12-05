// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol SearchRepository {
    func searchShopping(query: String, display: Int) -> AnyPublisher<ShoppingResultVO, Error>
}
