// Copyright © 2023 com.template. All rights reserved.

import Swinject
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let navigationController: UINavigationController
    private let appCoordinator: AppCoordinator
    private let injector: DependencyInjector
    
    override init() {
        let container = Container()
        
        navigationController = UINavigationController()
        appCoordinator = AppCoordinator(container: container, navigationController: navigationController)
        injector = DependencyInjector(container: container)
        
        injector.assemble([
            DomainAssembly(),
            DataAssembly(),
            PresentationAssembly()
        ])
    }
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        appCoordinator.start()
    }
    
    // 딥링크 발생시 해당 코드 실행됨
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        appCoordinator.handleDeepLink(url: url)
    }
}
