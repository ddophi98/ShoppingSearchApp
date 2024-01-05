// Copyright © 2023 com.shoppingSearch. All rights reserved.

struct ShoppingProductTapped: LoggingSchemeVO {
    let logVersion: Float = 1.0
    let eventName: String = "Product Tapped"
    let screenName: String = "ShoppingList"
    var logData: Array<(String, String)> = []
    
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
    
    final class Builder {
        private var productName: String?
        private var productPrice: Int?
        private var productPosition: String?
        private var productIndex: Int?
        
        func setProductName(_ productName: String) -> Builder {
            self.productName = productName
            return self
        }
        func setProductPrice(_ productPrice: Int) -> Builder {
            self.productPrice = productPrice
            return self
        }
        func setProductPosition(_ productPosition: String) -> Builder {
            self.productPosition = productPosition
            return self
        }
        func setProductIndex(_ productIndex: Int) -> Builder {
            self.productIndex = productIndex
            return self
        }
        
        func build() -> LoggingSchemeVO {
            return ShoppingProductTapped(
                productName: productName,
                productPrice: productPrice,
                productPosition: productPosition,
                productIndex: productIndex
            )
        }
    }
}
