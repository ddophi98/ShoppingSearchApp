// Copyright © 2023 com.template. All rights reserved.

import Domain
import RxSwift
import RxCocoa

public class BaseViewModel {
    var disposeBag = DisposeBag()
    let errorRelay = PublishRelay<String>()
    
    func setError(error: Error) {
        if let error = error as? CustomError {
            switch error {
                case .NetworkError(let detail):
                    errorRelay.accept(detail)
                case .UndefinedError:
                    errorRelay.accept("원인을 알 수 없는 에러 발생")
            }
        } else {
            errorRelay.accept("원인을 알 수 없는 에러 발생")
        }
    }
}
