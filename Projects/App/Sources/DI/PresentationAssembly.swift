// Copyright © 2023 com.template. All rights reserved.

import Swinject
import Presentation
import Domain

public struct PresentationAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(RandomCatViewModel.self) { resolver in
            let usecase = resolver.resolve(RandomCatUsecase.self)!
            return RandomCatViewModel(usecase: usecase)
        }
        container.register(RandomCatView.self) { resolver in
            let viewModel = resolver.resolve(RandomCatViewModel.self)!
            return RandomCatView(viewModel: viewModel)
        }
    }
}
