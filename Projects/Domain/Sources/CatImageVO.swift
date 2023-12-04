// Copyright © 2023 com.template. All rights reserved.

import Foundation

public struct CatImageVO {
    public let id: String
    public let width: Float
    public let height: Float
    public let url: String
    
    public init(id: String, width: Float, height: Float, url: String) {
        self.id = id
        self.width = width
        self.height = height
        self.url = url
    }
}
