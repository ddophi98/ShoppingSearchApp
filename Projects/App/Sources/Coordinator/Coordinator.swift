// Copyright © 2023 com.template. All rights reserved.

import Domain
import UIKit
import Swinject

public protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get }
    var container: Container { get }
    func start()
}
