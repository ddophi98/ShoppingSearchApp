// Copyright © 2023 com.template. All rights reserved.

import Swinject
import Domain

public struct DomainAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(ShoppingListUsecase.self) { resolver in
            let searchRepository = resolver.resolve(SearchRepository.self)!
            let imageRepository = resolver.resolve(ImageRepository.self)!
            return DefaultShoppingResultUsecase(searchRepository: searchRepository, imageRepository: imageRepository)
        }
        container.register(BasketUsecase.self) { resolver in
            let repository = resolver.resolve(ServerDrivenRepository.self)!
            return DefaultBasketUsecase(repository: repository)
        }
        container.register(DetailUsecase.self) { resolver in
            return DefaultDetailUsecase()
        }
    }
}
