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
        startWithShoppingList()
    }
    
    func handleDeepLink(url: URL) {
        guard let host = url.host else { return }
        
        // 원래 보고 있던 화면 다 지우고
        firstTabNavigationController.viewControllers.removeAll()
        secondTabNavigationController.viewControllers.removeAll()
        
        // 딥링크 화면 띄워주기
        switch host {
        case "shoppingList":
            startWithShoppingList()
        case "basket":
            startWithBasket()
        case "detail":
            guard let params = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems,
                  let id = Int(params.first(where: { $0.name == "id" })?.value ?? "")
            else { break }
            startWithDetail(id: id)
        default:
            startWithShoppingList()
        }
    }
    
    private func setFirstTabCoordinator() -> FirstTabCoordinator {
        let firstTabCoordinator = FirstTabCoordinator(container: container, navigationController: firstTabNavigationController)
        firstTabCoordinator.parentCoordinator = self
        children.append(firstTabCoordinator)
        
        return firstTabCoordinator
    }
    
    private func setSecondTabCoordinator() -> SecondTabCoordinator {
        let secondTabCoordinator = SecondTabCoordinator(container: container, navigationController: secondTabNavigationController)
        secondTabCoordinator.parentCoordinator = self
        children.append(secondTabCoordinator)
        
        return secondTabCoordinator
    }
    
    private func setTabView() {
        
    }
    
    private func startWithShoppingList() {
        let tabView = container.resolve(TabView.self, arguments: firstTabNavigationController, secondTabNavigationController)!
        navigationController.viewControllers = [tabView]
        
        let firstTabCoordinator = setFirstTabCoordinator()
        let secondTabCoordinator = setSecondTabCoordinator()
        
        firstTabCoordinator.start()
        secondTabCoordinator.start()
    }

    private func startWithBasket() {
        let tabView = container.resolve(TabView.self, arguments: firstTabNavigationController, secondTabNavigationController)!
        tabView.selectedIndex = 1
        navigationController.viewControllers = [tabView]
        
        let firstTabCoordinator = setFirstTabCoordinator()
        let secondTabCoordinator = setSecondTabCoordinator()
        
        firstTabCoordinator.start()
        secondTabCoordinator.start()
    }
    
    private func startWithDetail(id: Int) {
        let tabView = container.resolve(TabView.self, arguments: firstTabNavigationController, secondTabNavigationController)!
        navigationController.viewControllers = [tabView]
        
        let firstTabCoordinator = setFirstTabCoordinator()
        let secondTabCoordinator = setSecondTabCoordinator()
        
        firstTabCoordinator.start()
        // 원래라면 id 값으로 특정 상품 조회할 것이라고 예상됨, 현재는 임시 데이터 사용
        firstTabCoordinator.moveToDetailView(item: ShoppingItemVO.sample)
        secondTabCoordinator.start()
        
    }
}
