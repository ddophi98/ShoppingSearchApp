// Copyright © 2023 com.template. All rights reserved.

import Swinject
import Domain

public struct DomainAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(ShoppingListUsecase.self) { resolver in
            let searchRepository = resolver.resolve(SearchRepository.self)!
            let imageRepository = resolver.resolve(ImageRepository.self)!
            let loggingRepository = resolver.resolve(LoggingRepository.self)!
            return DefaultShoppingResultUsecase(searchRepository: searchRepository, imageRepository: imageRepository, loggingRepository: loggingRepository)
        }
        container.register(BasketUsecase.self) { resolver in
            let serverDrivenRepository = resolver.resolve(ServerDrivenRepository.self)!
            let imageRepository = resolver.resolve(ImageRepository.self)!
            let loggingRepository = resolver.resolve(LoggingRepository.self)!
            return DefaultBasketUsecase(serverDrivenRepository: serverDrivenRepository, imageRepository: imageRepository, loggingRepository: loggingRepository)
        }
        container.register(DetailUsecase.self) { resolver in
            let imageRepository = resolver.resolve(ImageRepository.self)!
            let loggingRepository = resolver.resolve(LoggingRepository.self)!
            return DefaultDetailUsecase(imageRepository: imageRepository, loggingRepository: loggingRepository)
        }
    }
}
