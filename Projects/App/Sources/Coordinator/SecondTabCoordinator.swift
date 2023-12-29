// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation
import Presentation
import UIKit
import Swinject

final class SecondTabCoordinator: Coordinator, SecondTabNavigation {
    let navigationController: UINavigationController
    let container: Container
    
    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }
    
    func start() {
        let basketView = container.resolve(BasketView.self)!
        basketView.setCoordinator(self)
        navigationController.pushViewController(basketView, animated: false)
    }
}
