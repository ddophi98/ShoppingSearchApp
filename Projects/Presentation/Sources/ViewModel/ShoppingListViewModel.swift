// Copyright © 2023 com.template. All rights reserved.

import Combine
import Domain
import Foundation

final public class ShoppingListViewModel: BaseViewModel {
    @Published private(set) var shoppingResultVO: ShoppingResultVO?
    public let usecase: ShoppingListUsecase
    
    public init(usecase: ShoppingListUsecase) {
        self.usecase = usecase
    }
}
