// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol LoggingDatasource {
    func shotLog(_ scheme: String)
}

final public class DefaultLoggingDatasource: LoggingDatasource {
    
    public init() { }

    private let logger = Logger(appVersion: "1.0", osVersion: "iOS")
    
    public func shotLog(_ scheme: String) {
        logger.shotLog(scheme)
    }
}
