// Copyright © 2023 com.template. All rights reserved.

import Domain
import Presentation
import Swinject
import UIKit

struct PresentationAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        // --- ViewModel ---
        container.register(ShoppingListViewModel.self) { (resolver, coordinator: FirstTabCoordinator) in
            let productUsecase = resolver.resolve(ProductUsecase.self)!
            let loggingUsecase = resolver.resolve(LoggingUsecase.self)!
            return ShoppingListViewModel(productUsecase: productUsecase, loggingUsecase: loggingUsecase, coordinator: coordinator)
        }
        container.register(DetailViewModel.self) { (resolver, coordinator: FirstTabCoordinator, item: ShoppingItemVO) in
            let productUsecase = resolver.resolve(ProductUsecase.self)!
            let loggingUsecase = resolver.resolve(LoggingUsecase.self)!
            return DetailViewModel(productUsecase: productUsecase, loggingUsecase: loggingUsecase, coordinator: coordinator, item: item)
        }
        container.register(BasketViewModel.self) { (resolver, coordinator: SecondTabCoordinator) in
            let productUsecase = resolver.resolve(ProductUsecase.self)!
            let loggingUsecase = resolver.resolve(LoggingUsecase.self)!
            return BasketViewModel(productUsecase: productUsecase, loggingUsecase: loggingUsecase, coordinator: coordinator)
        }
        
        // --- View ---
        container.register(TabView.self) { (resolver, nc1: UINavigationController, nc2: UINavigationController ) in
            return TabView(firstView: nc1, secondView: nc2)
        }
        container.register(ShoppingListView.self) { (resolver, coordinator: FirstTabCoordinator) in
            let viewModel = resolver.resolve(ShoppingListViewModel.self, argument: coordinator)!
            return ShoppingListView(viewModel: viewModel)
        }
        container.register(DetailView.self) { (resolver, coordinator: FirstTabCoordinator, item: ShoppingItemVO) in
            let viewModel = resolver.resolve(DetailViewModel.self, arguments: coordinator, item)!
            return DetailView(viewModel: viewModel)
        }
        container.register(BasketView.self) { (resolver, coordinator: SecondTabCoordinator) in
            let viewModel = resolver.resolve(BasketViewModel.self, argument: coordinator)!
            return BasketView(viewModel: viewModel)
        }
    }
}
