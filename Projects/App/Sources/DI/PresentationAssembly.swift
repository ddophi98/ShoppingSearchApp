// Copyright © 2023 com.template. All rights reserved.

import Swinject
import Presentation
import Domain

public struct PresentationAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(ShoppingListViewModel.self) { resolver in
            let usecase = resolver.resolve(ShoppingListUsecase.self)!
            return ShoppingListViewModel(usecase: usecase)
        }
        container.register(ShoppingListView.self) { resolver in
            let viewModel = resolver.resolve(ShoppingListViewModel.self)!
            return ShoppingListView(viewModel: viewModel)
        }
    }
}
