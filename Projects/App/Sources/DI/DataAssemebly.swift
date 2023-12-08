// Copyright © 2023 com.template. All rights reserved.

import Swinject
import Data
import Domain

public struct DataAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(SearchDatasource.self) { _ in
            return DefaultSearchDatasource()
        }
        container.register(ImageDatasource.self) { _ in
            return DefaultImageDatasource()
        }
        container.register(ServerDrivenDatasource.self) { _ in
            return DefaultServerDrivenDatasource()
        }
        container.register(SearchRepository.self) { resolver in
            let datasource = resolver.resolve(SearchDatasource.self)!
            return DefaultSearchRepository(dataSource: datasource)
        }
        container.register(ImageRepository.self) { resolver in
            let dataSource = resolver.resolve(ImageDatasource.self)!
            return DefaultImageRepository(dataSource: dataSource)
        }
        container.register(ServerDrivenRepository.self) { resolver in
            let datasource = resolver.resolve(ServerDrivenDatasource.self)!
            return DefaultServerDrivenRepository(datasource: datasource)
        }
    }
}
