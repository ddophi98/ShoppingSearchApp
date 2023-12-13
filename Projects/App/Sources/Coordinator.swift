// Copyright © 2023 com.template. All rights reserved.

import Domain
import Presentation
import Swinject
import UIKit

class MainCoordinator: Coordinator {
    private let  navigationController: UINavigationController
    private let container: Container
    
    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func initFirstTab() {
        let shoppingListView = container.resolve(ShoppingListView.self)!
        shoppingListView.setCoordinator(self)
        navigationController.pushViewController(shoppingListView, animated: false)
    }
    
    func initSecondTab() {
        let basketView = container.resolve(BasketView.self)!
        basketView.setCoordinator(self)
        navigationController.pushViewController(basketView, animated: false)
    }
    
    func moveToDetailView(item: ShoppingItemVO) {
        let detailView = container.resolve(DetailView.self, argument: item)!
        detailView.setCoordinator(self)
        navigationController.pushViewController(detailView, animated: true)
    }
}
