// Copyright © 2023 com.template. All rights reserved.

import Foundation
import Domain
import RxSwift

public final class DetailViewModel: BaseViewModel {
    private let productUsecase: ProductUsecase
    private let loggingUsecase: LoggingUsecase
    private let coordinator: FirstTabNavigation
    let item: ShoppingItemVO
    
    public init(productUsecase: ProductUsecase, loggingUsecase: LoggingUsecase, coordinator: FirstTabNavigation, item: ShoppingItemVO) {
        self.productUsecase = productUsecase
        self.loggingUsecase = loggingUsecase
        self.coordinator = coordinator
        self.item = item
    }
    
    func downloadImage(url: String) -> Single<Data> {
        productUsecase.downloadImage(url: url)
    }
    
    // --- logging ---
    func loggingViewAppeared() {
        loggingUsecase.loggingDetailViewAppeared()
    }
}
