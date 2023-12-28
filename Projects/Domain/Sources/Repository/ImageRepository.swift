// Copyright © 2023 com.template. All rights reserved.

import Foundation
import RxSwift

public protocol ImageRepository {
    func downloadImage(url: String) -> Single<Data>
    func setImageCache(url: String, data: Data)
}
