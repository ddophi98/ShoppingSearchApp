// Copyright © 2023 com.template. All rights reserved.

import Swinject
import Domain

public struct DomainAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
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
