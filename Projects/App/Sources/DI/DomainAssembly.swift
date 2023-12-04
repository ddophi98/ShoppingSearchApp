// Copyright © 2023 com.template. All rights reserved.

import Swinject
import Domain

public struct DomainAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(RandomCatUsecase.self) { resolver in
            let repository = resolver.resolve(ImageRepository.self)!
            return DefaultRandomCatUsecase(repository: repository)
        }
    }
}
