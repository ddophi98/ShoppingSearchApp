// Copyright © 2023 com.template. All rights reserved.

import Domain
import Combine
import Foundation

final public class BasketViewModel: BaseViewModel {
    @Published private(set) var contents = [ServerDrivenContentVO]()
    
    private let usecase: BasketUsecase
    private var logsForTTI = Dictionary<TTIPoint, Date>()
    private var completeLoggingTTI = false
    
    public init(usecase: BasketUsecase) {
        self.usecase = usecase
    }
    
    func getBasketContents() {
        usecase.getBasketContents()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
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
        usecase.downloadImage(url: url)
    }
    
    func setImageCache(url: String, data: Data) {
        usecase.setImageCache(url: url, data: data)
    }
    
    // --- logging ---
    func loggingViewAppeared() {
        usecase.loggingViewAppeared()
    }
    
    func loggingTTI(point: TTIPoint) {
        if completeLoggingTTI {
            return
        }
        
        logsForTTI[point] = Date()
        if point == .drawCoreComponent {
            usecase.loggingTTI(logs: logsForTTI)
            completeLoggingTTI = true
        }
    }
}
