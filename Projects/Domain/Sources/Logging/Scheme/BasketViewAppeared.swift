// Copyright © 2023 com.shoppingSearch. All rights reserved.

struct BasketViewAppeared: LoggingSchemeVO {
    let logVersion: Float = 1.0
    let eventName: String = "ViewAppeared"
    let screenName: String = "Basket"
    var logData: Array<(String, String)> = []
    
    private init() { }
    
    final class Builder {
        func build() -> LoggingSchemeVO {
            return BasketViewAppeared()
        }
    }
}
