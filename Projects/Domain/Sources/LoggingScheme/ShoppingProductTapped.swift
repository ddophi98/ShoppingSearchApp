// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation

public struct ShoppingProductTapped: LoggingScheme {
    public var logVersion: Float = 1.0
    public var eventName: String = "Product Tapped"
    public var screenName: String = "ShoppingList"
    public var logData: Array<(String, String)> = []
    
    private init(productName: String?, productPrice: Int?, productPosition: String?, productIndex: Int?) {
        if let productName = productName {
            logData.append(("productName", productName))
        }
        if let productPrice = productPrice {
            logData.append(("productPrice", String(productPrice)))
        }
        if let productPosition = productPosition {
            logData.append(("productPosition", productPosition))
        }
        if let productIndex = productIndex {
            logData.append(("productIndex", String(productIndex)))
        }
    }
    
    public class Builder {
        var productName: String?
        var productPrice: Int?
        var productPosition: String?
        var productIndex: Int?
        
        public func setProductName(_ productName: String) -> Builder {
            self.productName = productName
            return self
        }
        
        public func setProductPrice(_ productPrice: Int) -> Builder {
            self.productPrice = productPrice
            return self
        }
        
        public func setProductPosition(_ productPosition: String) -> Builder {
            self.productPosition = productPosition
            return self
        }
        
        public func setProductIndex(_ productIndex: Int) -> Builder {
            self.productIndex = productIndex
            return self
        }
        
        public func build() -> LoggingScheme {
            return ShoppingProductTapped(
                productName: productName,
                productPrice: productPrice,
                productPosition: productPosition,
                productIndex: productIndex
            )
        }
    }
}
