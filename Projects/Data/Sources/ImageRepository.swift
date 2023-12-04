// Copyright © 2023 com.template. All rights reserved.

import Combine
import Domain
import Foundation

final public class DefaultImageRepository: ImageRepository {
    private let dataSource: ImageDatasource
    
    public init(dataSource: ImageDatasource) {
        self.dataSource = dataSource
    }
    
    public func loadCatImage() -> AnyPublisher<[CatImageVO], Error> {
        dataSource.loadCatImage()
            .map({ catImageDTOs in
                catImageDTOs.map {
                    $0.toVO()
                }
            })
            .eraseToAnyPublisher()
    }
    
    public func download(url: String) -> AnyPublisher<Data, Error> {
        dataSource.download(url: url)
    }
}
