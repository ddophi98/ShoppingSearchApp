// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation

public struct ShoppingProductSearched: LoggingScheme {
    public var logVersion: Float = 1.0
    public var eventName: String = "Searched"
    public var screenName: String = "ShoppingList"
    public var logData: [String : String] = [:]
    
    private init(query: String?) {
        if let query = query {
            logData["query"] = query
        }
    }
    
    public class Builder {
        var query: String?
        
        public func setQuery(_ query: String) -> Builder {
            self.query = query
            return self
        }
        
        public func build() -> LoggingScheme {
            return ShoppingProductSearched(query: query)
        }
    }
}
