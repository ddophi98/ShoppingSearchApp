// Copyright © 2023 com.template. All rights reserved.

import Domain

public final class DetailViewModel: BaseViewModel {
    private let usecase: DetailUsecase
    
    public init(usecase: DetailUsecase) {
        self.usecase = usecase
    }
    
}
