// Copyright © 2023 com.template. All rights reserved.

import Foundation

public struct ShoppingResultVO {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [ShoppingItemVO]
    
    public init(lastBuildDate: String, total: Int, start: Int, display: Int, items: [ShoppingItemVO]) {
        self.lastBuildDate = lastBuildDate
        self.total = total
        self.start = start
        self.display = display
        self.items = items
    }
}

public struct ShoppingItemVO: Codable {
    let title: String
    let link: String
    let image: String
    let lprice: Int
    let hprice: Int
    let mallName: String
    let productId: Int
    let productType: Int
    let brand: String
    let maker: String
    let category1: String
    let category2: String
    let category3: String
    let category4: String
    
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
