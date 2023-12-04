// Copyright © 2023 com.template. All rights reserved.

import Swinject
import Data
import Domain

public struct DataAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(ImageDatasource.self) { _ in
            return DefaultImageDatasource()
        }
        container.register(ImageRepository.self) { resolver in
            let dataSource = resolver.resolve(ImageDatasource.self)!
            return DefaultImageRepository(dataSource: dataSource)
        }
    }
}
