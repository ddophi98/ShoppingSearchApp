// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol ImageRepository {
    func loadCatImage() -> AnyPublisher<[CatImageVO], Error>
    func download(url: String) -> AnyPublisher<Data, Error>
}
