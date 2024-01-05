// Copyright © 2023 com.template. All rights reserved.

import Swinject
import UIKit

protocol Coordinator: AnyObject {
    var navigationController : UINavigationController { get }
    var container: Container { get }
    func start()
}
