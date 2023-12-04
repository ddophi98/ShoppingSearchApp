// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol ImageDatasource {
    func loadCatImage() -> AnyPublisher<[CatImageDTO], Error>
    func download(url: String) -> AnyPublisher<Data, Error>
}

final public class DefaultImageDatasource: ImageDatasource {
    
    public init() { }
    
    private let moyaProvider = MoyaWrapper<ImageAPI>()
    
    public func loadCatImage() -> AnyPublisher<[CatImageDTO], Error> {
        moyaProvider.call(target: .catImage)
    }
    
    public func download(url: String) -> AnyPublisher<Data, Error> {
        URLSession.shared.call(url: url)
    }
}
