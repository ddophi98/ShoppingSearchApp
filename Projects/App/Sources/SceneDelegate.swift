// Copyright © 2023 com.template. All rights reserved.

import UIKit
import Swinject
import Presentation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private let injector: Injector
    
    override init() {
        self.injector = DependencyInjector(container: Container())
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
        window?.rootViewController = injector.resolve(TabView.self)
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {}
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {}
    
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
