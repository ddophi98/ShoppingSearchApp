// Copyright © 2023 com.template. All rights reserved.

import Foundation
import Domain
import RxSwift

public final class DetailViewModel: BaseViewModel {
    private let productUsecase: ProductUsecase
    private let loggingUsecase: LoggingUsecase
    var coordinator: FirstTabNavigation?
    let item: ShoppingItemVO
    
    public init(productUsecase: ProductUsecase, loggingUsecase: LoggingUsecase, item: ShoppingItemVO) {
        self.productUsecase = productUsecase
        self.loggingUsecase = loggingUsecase
        self.item = item
    }
    
    func downloadImage(url: String) -> Single<Data> {
        productUsecase.downloadImage(url: url)
    }
    
    func setImageCache(url: String, data: Data) {
        productUsecase.setImageCache(url: url, data: data)
    }
    
    // --- logging ---
    func loggingViewAppeared() {
        loggingUsecase.loggingDetailViewAppeared()
    }
}
