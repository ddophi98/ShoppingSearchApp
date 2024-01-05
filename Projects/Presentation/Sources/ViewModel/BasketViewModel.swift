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
        loggingSendRequest()
        productUsecase.getBasketContents()
            .subscribe( onSuccess: { [weak self] response in
                guard let self = self else { return }
                contents = response
                contentsAreChanged.accept(())
                loggingReceiveResponse()
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                setError(error: error)
            })
            .disposed(by: disposeBag)
    }
    func downloadImage(url: String) -> Single<Data> {
        productUsecase.downloadImage(url: url)
    }
    
    // --- 로깅 관련 메소드 ---
    func loggingLoadView() {
        loggingTTI(point: .loadView)
    }
    func loggingDrawView() {
        loggingUsecase.loggingBasketViewAppeared()
        loggingTTI(point: .drawView)
    }
    func loggingBindData() {
        loggingTTI(point: .bindData)
    }
    func loggingDrawCoreComponent() {
        loggingTTI(point: .drawCoreComponent)
    }
    private func loggingSendRequest() {
        loggingTTI(point: .sendRequest)
    }
    private func loggingReceiveResponse() {
        loggingTTI(point: .receiveResponse)
    }
    private func loggingTTI(point: TTIPoint) {
        // 화면이 최초로 나타날때만 측정하기
        if completeLoggingTTI {
            return
        }
        logsForTTI[point] = Date()
        // 마지막 시점이라면 기록한 로그 보내기
        if point == .drawCoreComponent {
            loggingUsecase.loggingBasketViewTTI(logs: logsForTTI)
            completeLoggingTTI = true
        }
    }
}
