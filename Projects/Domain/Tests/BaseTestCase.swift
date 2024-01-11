// Copyright © 2024 com.shoppingSearch. All rights reserved.

import XCTest

class BaseTestCase: XCTestCase {
    func given(_ task: () -> Void) {
        task()
    }
    func when(_ task: () -> Void) {
        task()
    }
    func then(_ task: () -> Void) {
        task()
    }
}
