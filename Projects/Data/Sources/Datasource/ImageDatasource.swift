// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol ImageDatasource {
    func downloadImage(url: String) -> AnyPublisher<Data, Error>
}

final public class DefaultImageDatasource: ImageDatasource {
    
    public init() { }
    
    public func downloadImage(url: String) -> AnyPublisher<Data, Error> {
        URLSession.shared.call(url: url)
    }
}
