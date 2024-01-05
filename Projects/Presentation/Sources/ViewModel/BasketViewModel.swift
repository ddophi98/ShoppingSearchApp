// Copyright © 2023 com.template. All rights reserved.

import Domain
import Foundation
import RxCocoa
import RxSwift

final public class BasketViewModel: BaseViewModel {
    private let productUsecase: ProductUsecase
    private let loggingUsecase: LoggingUsecase
    private let coordinator: SecondTabNavigation
    private var logsForTTI = Dictionary<TTIPoint, Date>()
    private var completeLoggingTTI = false
    private(set) var contents = [ServerDrivenContentVO]()
    let contentsAreChanged = PublishRelay<Void>()
    
    public init(productUsecase: ProductUsecase, loggingUsecase: LoggingUsecase, coordinator: SecondTabNavigation) {
        self.productUsecase = productUsecase
        self.loggingUsecase = loggingUsecase
        self.coordinator = coordinator
    }
    
    func getBasketContents() {
        productUsecase.getBasketContents()
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                contents = response
                contentsAreChanged.accept(())
                loggingTTI(point: .receiveResponse)
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                setError(error: error)
            })
            .disposed(by: disposeBag)
    }
    
    func downloadImage(url: String) -> Single<Data> {
        productUsecase.downloadImage(url: url)
    }
    
    // --- logging ---
    func loggingViewAppeared() {
        loggingUsecase.loggingBasketViewAppeared()
    }
    
    func loggingTTI(point: TTIPoint) {
        if completeLoggingTTI {
            return
        }
        
        logsForTTI[point] = Date()
        if point == .drawCoreComponent {
            loggingUsecase.loggingBasketViewTTI(logs: logsForTTI)
            completeLoggingTTI = true
        }
    }
}
