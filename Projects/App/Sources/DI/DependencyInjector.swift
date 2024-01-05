// Copyright © 2023 com.template. All rights reserved.

import Swinject

final class DependencyInjector {
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func assemble(_ assemblyList: [Swinject.Assembly]) {
        assemblyList.forEach { $0.assemble(container: container) }
    }
}
