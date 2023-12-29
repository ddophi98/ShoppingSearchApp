// Copyright © 2023 com.template. All rights reserved.

import Domain
import UIKit
import Swinject

protocol Coordinator: AnyObject {
    var navigationController : UINavigationController { get }
    var container: Container { get }
    func start()
}
