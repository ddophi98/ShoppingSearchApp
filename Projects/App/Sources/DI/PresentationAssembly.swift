// Copyright © 2023 com.template. All rights reserved.

import Swinject
import Presentation
import Domain
import UIKit

public struct PresentationAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(ShoppingListViewModel.self) { resolver in
            let productUsecase = resolver.resolve(ProductUsecase.self)!
            let loggingUsecase = resolver.resolve(LoggingUsecase.self)!
            return ShoppingListViewModel(productUsecase: productUsecase, loggingUsecase: loggingUsecase)
        }
        container.register(ShoppingListView.self) { resolver in
            let viewModel = resolver.resolve(ShoppingListViewModel.self)!
            return ShoppingListView(viewModel: viewModel)
        }
        container.register(BasketViewModel.self) { resolver in
            let productUsecase = resolver.resolve(ProductUsecase.self)!
            let loggingUsecase = resolver.resolve(LoggingUsecase.self)!
            return BasketViewModel(productUsecase: productUsecase, loggingUsecase: loggingUsecase)
        }
        container.register(BasketView.self) { resolver in
            let viewModel = resolver.resolve(BasketViewModel.self)!
            return BasketView(viewModel: viewModel)
        }
        container.register(DetailViewModel.self) { (resolver, item: ShoppingItemVO) in
            let productUsecase = resolver.resolve(ProductUsecase.self)!
            let loggingUsecase = resolver.resolve(LoggingUsecase.self)!
            return DetailViewModel(productUsecase: productUsecase, loggingUsecase: loggingUsecase, item: item)
        }
        container.register(DetailView.self) { (resolver, item: ShoppingItemVO) in
            let viewModel = resolver.resolve(DetailViewModel.self, argument: item)!
            return DetailView(viewModel: viewModel)
        }
        container.register(TabView.self) { (resolver, nc1: UINavigationController, nc2: UINavigationController ) in
            return TabView(firstView: nc1, secondView: nc2)
        }
    }
}
