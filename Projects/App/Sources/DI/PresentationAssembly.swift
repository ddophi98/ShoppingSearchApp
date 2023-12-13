// Copyright © 2023 com.template. All rights reserved.

import Swinject
import Presentation
import Domain
import UIKit

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
        container.register(BasketViewModel.self) { resolver in
            let usecase = resolver.resolve(BasketUsecase.self)!
            return BasketViewModel(usecase: usecase)
        }
        container.register(BasketView.self) { resolver in
            let viewModel = resolver.resolve(BasketViewModel.self)!
            return BasketView(viewModel: viewModel)
        }
        container.register(DetailViewModel.self) { (resolver, item: ShoppingItemVO) in
            let usecase = resolver.resolve(DetailUsecase.self)!
            return DetailViewModel(usecase: usecase, item: item)
        }
        container.register(DetailView.self) { (resolver, item: ShoppingItemVO) in
            let viewModel = resolver.resolve(DetailViewModel.self, argument: item)!
            return DetailView(viewModel: viewModel)
        }
        container.register(TabView.self) { resolver in
            let firstNavigationController = UINavigationController()
            let firstCoordinator = MainCoordinator(navigationController: firstNavigationController, container: container)
            firstCoordinator.initFirstTab()
            
            let secondNavigationController = UINavigationController()
            let secondCoordinator = MainCoordinator(navigationController: secondNavigationController, container: container)
            secondCoordinator.initSecondTab()
            
            return TabView(firstView: firstNavigationController, secondView: secondNavigationController)
        }
    }
}
