// Copyright © 2023 com.template. All rights reserved.

import Foundation

public struct ShoppingResultVO {
    public let lastBuildDate: String
    public let total: Int
    public let start: Int
    public let display: Int
    public let items: [ShoppingItemVO]
    
    public init(lastBuildDate: String, total: Int, start: Int, display: Int, items: [ShoppingItemVO]) {
        self.lastBuildDate = lastBuildDate
        self.total = total
        self.start = start
        self.display = display
        self.items = items
    }
}

public struct ShoppingItemVO: Codable {
    public let title: String
    public let link: String
    public let image: String
    public let lprice: Int
    public let hprice: Int
    public let mallName: String
    public let productId: Int
    public let productType: Int
    public let brand: String
    public let maker: String
    public let category1: String
    public let category2: String
    public let category3: String
    public let category4: String
    
    public init(title: String, link: String, image: String, lprice: Int, hprice: Int, mallName: String, productId: Int, productType: Int, brand: String, maker: String, category1: String, category2: String, category3: String, category4: String) {
        self.title = title
        self.link = link
        self.image = image
        self.lprice = lprice
        self.hprice = hprice
        self.mallName = mallName
        self.productId = productId
        self.productType = productType
        self.brand = brand
        self.maker = maker
        self.category1 = category1
        self.category2 = category2
        self.category3 = category3
        self.category4 = category4
    }
}
