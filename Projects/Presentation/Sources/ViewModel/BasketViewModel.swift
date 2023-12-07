// Copyright © 2023 com.template. All rights reserved.

import Domain

final public class BasketViewModel: BaseViewModel {
    private let usecase: BasketUsecase
    
    public init(usecase: BasketUsecase) {
        self.usecase = usecase
    }
}
