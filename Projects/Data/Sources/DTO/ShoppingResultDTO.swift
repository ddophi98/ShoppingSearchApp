// Copyright © 2023 com.template. All rights reserved.

/*
 {
     "lastBuildDate": "Mon, 04 Dec 2023 21:19:19 +0900",
     "total": 1425204,
     "start": 1,
     "display": 1,
     "items": [
         {
             "title": "[메이트북스] 내 인생의 첫 <b>주식</b> 공부",
             "link": "https://search.shopping.naver.com/gate.nhn?id=82903916680",
             "image": "https://shopping-phinf.pstatic.net/main_8290391/82903916680.jpg",
             "lprice": "15750",
             "hprice": "",
             "mallName": "책쟁이들",
             "productId": "82903916680",
             "productType": "2",
             "brand": "",
             "maker": "메이트북스",
             "category1": "출산/육아",
             "category2": "교구",
             "category3": "학습교구",
             "category4": "기타교구"
         }
     ]
 }
 */

import Domain

public struct ShoppingResultDTO: Decodable {
    let lastBuildDate: String?
    let total: Int?
    let start: Int?
    let display: Int?
    let items: [ShoppingItemDTO]
    
    func toVO() -> ShoppingResultVO {
        return ShoppingResultVO(
            lastBuildDate: lastBuildDate ?? "",
            total: total ?? -1,
            start: start ?? -1,
            display: display ?? -1,
            items: items.map { $0.toVO() }
        )
    }
}

public struct ShoppingItemDTO: Decodable {
    let title: String
    let link: String?
    let image: String?
    let lprice: String?
    let hprice: String?
    let mallName: String?
    let productId: String?
    let productType: String?
    let brand: String?
    let maker: String?
    let category1: String?
    let category2: String?
    let category3: String?
    let category4: String?
    
    func toVO() -> ShoppingItemVO {
        return ShoppingItemVO(
            title: title,
            link: link ?? "",
            image: image ?? "",
            lprice: Int(lprice ?? "") ?? -1,
            hprice: Int(hprice ?? "") ?? -1,
            mallName: mallName ?? "",
            productId: Int(productId ?? "") ?? -1,
            productType: Int(productType ?? "") ?? -1,
            brand: brand ?? "",
            maker: maker ?? "",
            category1: category1 ?? "",
            category2: category2 ?? "",
            category3: category3 ?? "",
            category4: category4 ?? ""
        )
    }
}
