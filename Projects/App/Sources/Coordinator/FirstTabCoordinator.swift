// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation
import Domain
import Presentation
import UIKit
import Swinject

final class FirstTabCoordinator: Coordinator, FirstTabNavigation {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
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
