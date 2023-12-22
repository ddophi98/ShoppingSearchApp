// Copyright © 2023 com.template. All rights reserved.

import Domain
import Combine
import Foundation

final public class BasketViewModel: BaseViewModel {
    @Published private(set) var contents = [ServerDrivenContentVO]()
    
    private let productUsecase: ProductUsecase
    private let loggingUsecase: LoggingUsecase
    private var logsForTTI = Dictionary<TTIPoint, Date>()
    private var completeLoggingTTI = false
    
    public init(productUsecase: ProductUsecase, loggingUsecase: LoggingUsecase) {
        self.productUsecase = productUsecase
        self.loggingUsecase = loggingUsecase
    }
    
    func getBasketContents() {
        productUsecase.getBasketContents()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.setError(error: error)
                default:
                    break
                }
            } receiveValue: { [weak self] contents in
                self?.contents = contents
                self?.loggingTTI(point: .receiveResponse)
            }
            .store(in: &cancellables)
    }
    
    func downloadImage(url: String) -> AnyPublisher<Data, Error> {
        productUsecase.downloadImage(url: url)
    }
    
    func setImageCache(url: String, data: Data) {
        productUsecase.setImageCache(url: url, data: data)
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
