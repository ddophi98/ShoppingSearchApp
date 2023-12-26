// Copyright © 2023 com.template. All rights reserved.

import Domain
import Foundation

final public class DefaultLoggingRepository: LoggingRepository {
    private let dataSource: LoggingDatasource
    
    public init(dataSource: LoggingDatasource) {
        self.dataSource = dataSource
    }
    
    public func shotLog(_ scheme: LoggingScheme) {
        dataSource.shotLog(scheme.toDTO())
    }
}
