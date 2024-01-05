// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Domain
import Presentation
import Swinject
import UIKit

final class FirstTabCoordinator: Coordinator, FirstTabNavigation {
    let navigationController: UINavigationController
    let container: Container
    
    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }
    
    func start() {
        let shoppingListView = container.resolve(ShoppingListView.self)!
        shoppingListView.setCoordinator(self)
        navigationController.pushViewController(shoppingListView, animated: false)
    }
    
    func moveToDetailView(item: ShoppingItemVO) {
        let detailView = container.resolve(DetailView.self, argument: item)!
        detailView.setCoordinator(self)
        navigationController.pushViewController(detailView, animated: true)
    }
}
