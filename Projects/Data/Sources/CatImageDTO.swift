// Copyright © 2023 com.template. All rights reserved.

import Domain

public struct CatImageDTO: Codable {
    let id: String?
    let width: Float?
    let height: Float?
    let url: String?
    
    func toVO() -> CatImageVO {
        CatImageVO(
            id: id ?? "",
            width: width ?? 0,
            height: height ?? 0,
            url: url ?? ""
        )
    }
}
