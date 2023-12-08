// Copyright © 2023 com.template. All rights reserved.

import Foundation

public enum ServerDrivenContentVO {
    case RecentlyViewed([RecentlyViewedVO])
    case WishList([WishListVO])
    case Advertisement(AdvertisementVO)
}

public struct RecentlyViewedVO {
    let title: String
    let image: String
    let price: Int
    
    public init(title: String, image: String, price: Int) {
        self.title = title
        self.image = image
        self.price = price
    }
}

public struct WishListVO {
    let title: String
    let price: Int
    
    public init(title: String, price: Int) {
        self.title = title
        self.price = price
    }
}

public struct AdvertisementVO {
    let image: String
    let text: String
    
    public init(image: String, text: String) {
        self.image = image
        self.text = text
    }
}
