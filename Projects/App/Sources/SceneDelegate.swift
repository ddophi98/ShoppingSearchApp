// Copyright © 2023 com.template. All rights reserved.

import UIKit
import Swinject
import Presentation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private let injector: Injector
    private let appCoordinator: AppCoordinator
    private let navigationController: UINavigationController
    
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
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        appCoordinator.handleDeepLink(url: url)
    }
}
