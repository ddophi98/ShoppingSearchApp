// Copyright © 2023 com.template. All rights reserved.

import Swinject
import Data
import Domain

public struct DataAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(SearchDatasource.self) { _ in
            return DefaultSearchDatasource()
        }
        container.register(SearchRepository.self) { resolver in
            let dataSource = resolver.resolve(SearchDatasource.self)!
            return DefaultSearchRepository(dataSource: dataSource)
        }
    }
}
