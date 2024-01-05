// Copyright © 2023 com.template. All rights reserved.

import Domain
import Swinject

struct DomainAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        // --- Usecase ---
        container.register(ProductUsecase.self) { resolver in
            let serverDrivenRepository = resolver.resolve(ServerDrivenRepository.self)!
            let imageRepository = resolver.resolve(ImageRepository.self)!
            let searchRepository = resolver.resolve(SearchRepository.self)!
            return DefaultProductUsecase(serverDrivenRepository: serverDrivenRepository, imageRepository: imageRepository, searchRepository: searchRepository)
        }
        container.register(LoggingUsecase.self) { resolver in
            let loggingRepository = resolver.resolve(LoggingRepository.self)!
            return DefaultLoggingUsecase(loggingRepository: loggingRepository)
        }
    }
}
