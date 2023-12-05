// Copyright © 2023 com.template. All rights reserved.

import Combine
import Domain
import Foundation

final public class DefaultImageRepository: ImageRepository {
    private let dataSource: ImageDatasource
    
    public init(dataSource: ImageDatasource) {
        self.dataSource = dataSource
    }
    
    public func downloadImage(url: String) -> AnyPublisher<Data, Error> {
        dataSource.downloadImage(url: url)
    }
}
