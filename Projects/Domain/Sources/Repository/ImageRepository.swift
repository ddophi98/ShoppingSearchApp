// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol ImageRepository {
    func downloadImage(url: String) -> AnyPublisher<Data, Error>
}
