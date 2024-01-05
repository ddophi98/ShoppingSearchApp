// Copyright © 2023 com.template. All rights reserved.

import Domain
import Presentation
import Swinject
import UIKit

struct PresentationAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        // --- ViewModel ---
        container.register(ShoppingListViewModel.self) { resolver in
            let productUsecase = resolver.resolve(ProductUsecase.self)!
            let loggingUsecase = resolver.resolve(LoggingUsecase.self)!
            return ShoppingListViewModel(productUsecase: productUsecase, loggingUsecase: loggingUsecase)
        }
        container.register(BasketViewModel.self) { resolver in
            let productUsecase = resolver.resolve(ProductUsecase.self)!
            let loggingUsecase = resolver.resolve(LoggingUsecase.self)!
            return BasketViewModel(productUsecase: productUsecase, loggingUsecase: loggingUsecase)
        }
        container.register(DetailViewModel.self) { (resolver, item: ShoppingItemVO) in
            let productUsecase = resolver.resolve(ProductUsecase.self)!
            let loggingUsecase = resolver.resolve(LoggingUsecase.self)!
            return DetailViewModel(productUsecase: productUsecase, loggingUsecase: loggingUsecase, item: item)
        }
        
        // --- View ---
        container.register(TabView.self) { (resolver, nc1: UINavigationController, nc2: UINavigationController ) in
            return TabView(firstView: nc1, secondView: nc2)
        }
        container.register(ShoppingListView.self) { resolver in
            let viewModel = resolver.resolve(ShoppingListViewModel.self)!
            return ShoppingListView(viewModel: viewModel)
        }
        container.register(BasketView.self) { resolver in
            let viewModel = resolver.resolve(BasketViewModel.self)!
            return BasketView(viewModel: viewModel)
        }
        container.register(DetailView.self) { (resolver, item: ShoppingItemVO) in
            let viewModel = resolver.resolve(DetailViewModel.self, argument: item)!
            return DetailView(viewModel: viewModel)
        }
    }
}
