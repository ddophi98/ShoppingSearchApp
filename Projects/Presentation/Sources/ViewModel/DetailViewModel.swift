// Copyright © 2023 com.template. All rights reserved.

import Foundation
import Domain
import Combine

public final class DetailViewModel: BaseViewModel {
    private let usecase: DetailUsecase
    let item: ShoppingItemVO
    
    public init(usecase: DetailUsecase, item: ShoppingItemVO) {
        self.usecase = usecase
        self.item = item
    }
    
    func downloadImage(url: String) -> AnyPublisher<Data, Error> {
        usecase.downloadImage(url: url)
    }
    
    func setImageCache(url: String, data: Data) {
        usecase.setImageCache(url: url, data: data)
    }
}
