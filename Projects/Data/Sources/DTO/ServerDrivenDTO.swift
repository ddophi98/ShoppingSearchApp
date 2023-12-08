// Copyright © 2023 com.template. All rights reserved.

import Foundation

/*
 https://gist.githubusercontent.com/ddophi98/14535628aa282fb22a1284d3bebc5a83/raw/a7bc11eeb7f8ad1f5b8e04cdb2a887bac29f5cae/JsonForServerDrivenUI
 */

struct ServerDrivenDTO: Decodable {
    let blocks: [ServerDrivenBlock]
}

struct ServerDrivenBlock: Decodable {
    let blockType: String
    let content: ServerDrivenContent?
    
    enum CodingKeys: String, CodingKey {
        case blockType
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        blockType = try container.decode(String.self, forKey: .blockType)
        content = try ServerDrivenContent(blockType: blockType, container: container)
    }
}

enum ServerDrivenContent {
    case RecentlyViewed([RecentlyViewedContent])
    case WishList([WishListContent])
    case Advertisement(AdvertisementContent)
    
    init?(blockType: String, container: KeyedDecodingContainer<ServerDrivenBlock.CodingKeys>) throws {
        switch blockType {
        case "RecentlyViewed":
            let content = try container.decode([RecentlyViewedContent].self, forKey: .content)
            self = .RecentlyViewed(content)
        case "WishList":
            let content = try container.decode([WishListContent].self, forKey: .content)
            self = .WishList(content)
        case "Advertisement":
            let content = try container.decode(AdvertisementContent.self, forKey: .content)
            self = .Advertisement(content)
        default:
            return nil
        }
    }
}


struct RecentlyViewedContent: Decodable {
    let title: String?
    let image: String?
    let price: Int?
}

struct WishListContent: Decodable {
    let title: String?
    let price: Int?
}

struct AdvertisementContent: Decodable {
    let image: String?
    let text: String?
}
