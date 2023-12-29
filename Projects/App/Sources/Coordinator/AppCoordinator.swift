// Copyright © 2023 com.template. All rights reserved.

import Domain
import Presentation
import Swinject
import UIKit

final class AppCoordinator: Coordinator {
    private let firstTabNavigationController = UINavigationController()
    private let secondTabNavigationController = UINavigationController()
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    let navigationController: UINavigationController
    let container: Container
    
    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }
    
    func start() {
        setFirstTabCoordinator()
        setSecondTabCoordinator()

        let tabView = container.resolve(TabView.self, arguments: firstTabNavigationController, secondTabNavigationController)!
        navigationController.pushViewController(tabView, animated: false)
    }
    
    private func setFirstTabCoordinator() {
        let firstTabCoordinator = FirstTabCoordinator(container: container, navigationController: firstTabNavigationController)
        firstTabCoordinator.parentCoordinator = self
        children.append(firstTabCoordinator)
        firstTabCoordinator.start()
    }
    
    private func setSecondTabCoordinator() {
        let secondTabCoordinator = SecondTabCoordinator(container: container, navigationController: secondTabNavigationController)
        secondTabCoordinator.parentCoordinator = self
        children.append(secondTabCoordinator)
        secondTabCoordinator.start()
    }
}
