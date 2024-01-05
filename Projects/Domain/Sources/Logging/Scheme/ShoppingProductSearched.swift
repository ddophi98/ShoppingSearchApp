// Copyright © 2023 com.shoppingSearch. All rights reserved.

struct ShoppingProductSearched: LoggingSchemeVO {
    let logVersion: Float = 1.0
    let eventName: String = "Searched"
    let screenName: String = "ShoppingList"
    var logData: Array<(String, String)> = []
    
    private init(query: String?) {
        if let query = query {
            logData.append(("query", query))
        }
    }
    
    final class Builder {
        private var query: String?
        
        func setQuery(_ query: String) -> Builder {
            self.query = query
            return self
        }
        
        func build() -> LoggingSchemeVO {
            return ShoppingProductSearched(query: query)
        }
    }
}
