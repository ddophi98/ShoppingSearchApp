// Copyright © 2023 com.template. All rights reserved.

import Swinject
import Domain

public struct DomainAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(ShoppingListUsecase.self) { resolver in
            let repository = resolver.resolve(SearchRepository.self)!
            return DefaultShoppingResultUsecase(repository: repository)
        }
    }
}
