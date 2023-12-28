// Copyright © 2023 com.template. All rights reserved.

import Foundation

public protocol LoggingDatasource {
    func shotLog(_ scheme: LoggingSchemeDTO)
}

final public class DefaultLoggingDatasource: LoggingDatasource {
    
    public init() { }

    private let logger = Logger()
    
    public func shotLog(_ scheme: LoggingSchemeDTO) {
        logger.shotLog(scheme.scheme)
    }
}
