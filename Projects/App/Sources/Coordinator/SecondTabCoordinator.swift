// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Presentation
import Swinject
import UIKit

final class SecondTabCoordinator: Coordinator, SecondTabNavigation {
    let navigationController: UINavigationController
    let container: Container
    
    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }
    
    func start() {
        let basketView = container.resolve(BasketView.self, argument: self)!
        navigationController.pushViewController(basketView, animated: false)
    }
}
