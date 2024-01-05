// Copyright © 2023 com.template. All rights reserved.

public protocol LoggingDatasource {
    func shotLog(_ loggingScheme: LoggingSchemeDTO)
}

final public class DefaultLoggingDatasource: LoggingDatasource {
    private let logger = Logger()
    
    public init() { }
    
    public func shotLog(_ loggingSchemeDTO: LoggingSchemeDTO) {
        logger.shotLog(loggingSchemeDTO.scheme)
    }
}
