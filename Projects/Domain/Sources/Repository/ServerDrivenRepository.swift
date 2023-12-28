// Copyright © 2023 com.template. All rights reserved.

import RxSwift

public protocol ServerDrivenRepository {
    func getBasketContents() -> Single<[ServerDrivenContentVO]>
}
