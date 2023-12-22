// Copyright © 2023 com.template. All rights reserved.

import Combine
import Domain

public class BaseViewModel {
    var coordinator: Coordinator?
    var cancellables = Set<AnyCancellable>()
    @Published private(set) var error: CustomError?
    
    func setError(error: Error) {
        if let error = error as? CustomError {
            self.error = error
        } else {
            self.error = CustomError.UndefinedError
        }
    }
}
