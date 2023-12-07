// Copyright © 2023 com.template. All rights reserved.

import Combine

public class BaseViewModel {
    var coordinator: Coordinator?
    var cancellable = Set<AnyCancellable>()
}
