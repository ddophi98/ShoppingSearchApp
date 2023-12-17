// Copyright © 2023 com.template. All rights reserved.

import Domain

/*
 {
    "blocks":[
       {
          "blockType":"RecentlyViewed",
          "content":[
             {
                "title":"불멍 무드등 벽난로 불타는 LED 조명 무선 집들이 크리스마스",
                "image":"https://shopping-phinf.pstatic.net/main_8274220/82742201419.9.jpg",
                "price":12500
             },
             {
                "title":"얼모스트블루 블러쉬 체크 머플러",
                "image":"https://shopping-phinf.pstatic.net/main_2928744/29287448076.20231017124855.jpg",
                "price":21824
             },
             {
                "title":"스타벅스 DT 스탠리 스트로 텀블러 591ml",
                "image":"https://shopping-phinf.pstatic.net/main_1945030/19450308684.20190729143224.jpg",
                "price":13000
             },
             {
                "title":"카카오 캐릭터 춘식이 장패드",
                "image":"https://shopping-phinf.pstatic.net/main_8672770/86727706634.4.jpg",
                "price":13800
             },
             {
                "title":"PLAYMAX 포치타 체인소맨",
                "image":"https://shopping-phinf.pstatic.net/main_8668822/86688228006.2.jpg",
                "price":43000
             }
          ]
       },
       {
          "blockType":"WishList",
          "content":{
                "title":"Apple 에어팟 프로 2세대 (MQD83KH/A)",
                "price":284910
           }
       },
       {
          "blockType":"WishList",
          "content":{
                "title":"얼모스트블루 블러쉬 체크 머플러",
                "price":21824
           }
       },
       {
          "blockType":"Advertisement",
          "content":{
             "image":"https://shopping-phinf.pstatic.net/main_2180030/21800304853.20200205110947.jpg?type=f640",
             "text":"이번 겨울은 라이언 무드등과 함께 지내보세요! 방도 마음도 따뜻하게 비춰줍니다."
          }
       },
       {
          "blockType":"WishList",
          "content":{
                "title":"스타벅스 DT 스탠리 스트로 텀블러 591ml",
                "price":13000
           }
       },
       {
          "blockType":"WishList",
          "content":{
                "title":"불멍 무드등 벽난로 불타는 LED 조명 무선 집들이 크리스마스",
                "price":12500
           }
       },
       {
          "blockType":"WishList",
          "content":{
                "title":"삼성전자 게이밍 키보드 게이밍키보드 유선",
                "price":24300
           }
       },
       {
          "blockType":"WishList",
          "content":{
                "title":"카카오 프렌즈 라이언＆춘식이 USB 이글루 가습기 500ml (블루)",
                "price":31900
           }
       },
       {
          "blockType":"WishList",
          "content":{
                "title":"카카오 마우스패드 춘식이 죠르디 예쁜 귀여운 장패드 춘식이",
                "price":16900
           }
       }
    ]
 }
 */

public struct ServerDrivenDTO: Decodable {
    let blocks: [ServerDrivenBlockDTO]
}

public struct ServerDrivenBlockDTO: Decodable {
    let blockType: String
    let content: ServerDrivenContentDTO?
    
    enum CodingKeys: String, CodingKey {
        case blockType
        case content
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        blockType = try container.decode(String.self, forKey: .blockType)
        content = try ServerDrivenContentDTO(blockType: blockType, container: container)
    }
}

public enum ServerDrivenContentDTO {
    case RecentlyViewed([RecentlyViewedDTO])
    case WishList(WishListDTO)
    case Advertisement(AdvertisementDTO)
    
    init?(blockType: String, container: KeyedDecodingContainer<ServerDrivenBlockDTO.CodingKeys>) throws {
        switch blockType {
        case "RecentlyViewed":
            let content = try container.decode([RecentlyViewedDTO].self, forKey: .content)
            self = .RecentlyViewed(content)
        case "WishList":
            let content = try container.decode(WishListDTO.self, forKey: .content)
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
        case .WishList(let wishListDTO):
            return .WishList(wishListDTO.toVO() )
        case .Advertisement(let advertisementDTO):
            return .Advertisement(advertisementDTO.toVO())
        }
    }
}

public struct RecentlyViewedDTO: Decodable {
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

public struct WishListDTO: Decodable {
    let title: String?
    let price: Int?
    
    func toVO() -> WishListVO {
        return WishListVO(
            title: title ?? "",
            price: price ?? -1
        )
    }
}

public struct AdvertisementDTO: Decodable {
    let image: String?
    let text: String?
    
    func toVO() -> AdvertisementVO {
        return AdvertisementVO(
            image: image ?? "",
            text: text ?? ""
        )
    }
}
