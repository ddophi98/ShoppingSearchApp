// Copyright © 2023 com.template. All rights reserved.

import Domain

/*
 https://gist.githubusercontent.com/ddophi98/14535628aa282fb22a1284d3bebc5a83/raw/a7bc11eeb7f8ad1f5b8e04cdb2a887bac29f5cae/JsonForServerDrivenUI
 */

struct ServerDrivenDTO: Decodable {
    let blocks: [ServerDrivenBlockDTO]
}

struct ServerDrivenBlockDTO: Decodable {
    let blockType: String
    let content: ServerDrivenContentDTO?
    
    enum CodingKeys: String, CodingKey {
        case blockType
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        blockType = try container.decode(String.self, forKey: .blockType)
        content = try ServerDrivenContentDTO(blockType: blockType, container: container)
    }
}

enum ServerDrivenContentDTO {
    case RecentlyViewed([RecentlyViewedDTO])
    case WishList([WishListDTO])
    case Advertisement(AdvertisementDTO)
    
    init?(blockType: String, container: KeyedDecodingContainer<ServerDrivenBlockDTO.CodingKeys>) throws {
        switch blockType {
        case "RecentlyViewed":
            let content = try container.decode([RecentlyViewedDTO].self, forKey: .content)
            self = .RecentlyViewed(content)
        case "WishList":
            let content = try container.decode([WishListDTO].self, forKey: .content)
            self = .WishList(content)
        case "Advertisement":
            let content = try container.decode(AdvertisementDTO.self, forKey: .content)
            self = .Advertisement(content)
        default:
            return nil
        }
    }
    
    func toVO() -> ServerDrivenContentVO {
        switch self {
        case .RecentlyViewed(let recentlyViewedDTOs):
            return .RecentlyViewed(recentlyViewedDTOs.map { $0.toVO() })
        case .WishList(let wishListDTOs):
            return .WishList(wishListDTOs.map { $0.toVO() })
        case .Advertisement(let advertisementDTO):
            return .Advertisement(advertisementDTO.toVO())
        }
    }
}

struct RecentlyViewedDTO: Decodable {
    let title: String?
    let image: String?
    let price: Int?
    
    func toVO() -> RecentlyViewedVO {
        return RecentlyViewedVO(
            title: title ?? "",
            image: image ?? "",
            price: price ?? -1
        )
    }
}

struct WishListDTO: Decodable {
    let title: String?
    let price: Int?
    
    func toVO() -> WishListVO {
        return WishListVO(
            title: title ?? "",
            price: price ?? -1
        )
    }
}

struct AdvertisementDTO: Decodable {
    let image: String?
    let text: String?
    
    func toVO() -> AdvertisementVO {
        return AdvertisementVO(
            image: image ?? "",
            text: text ?? ""
        )
    }
}
