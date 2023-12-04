// Copyright © 2023 com.template. All rights reserved.

import Swinject

public protocol Injector {
    func assemble(_ assemblyList: [Assembly])
    func register<T>(_ serviceType: T.Type, _ object: T)
    func resolve<T>(_ serviceType: T.Type) -> T
}

public final class DependencyInjector: Injector {
    
    private let container: Container
    
    public init(container: Container) {
        self.container = container
    }
    
    public func assemble(_ assemblyList: [Swinject.Assembly]) {
        assemblyList.forEach { $0.assemble(container: container) }
    }
    
    public func register<T>(_ serviceType: T.Type, _ object: T) {
        container.register(serviceType) { _ in object}
    }
    
    public func resolve<T>(_ serviceType: T.Type) -> T {
        container.resolve(serviceType)!
    }
}
