// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation

public struct ShoppingListViewAppeared: LoggingScheme {
    public var logVersion: Float = 1.0
    public var eventName: String = "ViewAppeared"
    public var screenName: String = "ShoppingList"
    public var logData: [String : String] = [:]
    
    private init() { }
    
    public class Builder {
        public func build() -> LoggingScheme {
            return ShoppingListViewAppeared()
        }
    }
}
