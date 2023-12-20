// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation

public struct DetailViewAppeared: LoggingScheme {
    public var logVersion: Float = 1.0
    public var eventName: String = "ViewAppeared"
    public var screenName: String = "Detail"
    public var logData: Array<(String, String)> = []
    
    private init() { }
    
    public class Builder {
        public func build() -> LoggingScheme {
            return DetailViewAppeared()
        }
    }
}