// Copyright © 2023 com.template. All rights reserved.

import Foundation
import RxSwift

public protocol SearchRepository {
    func searchShopping(query: String) -> Single<ShoppingResultVO>
}
