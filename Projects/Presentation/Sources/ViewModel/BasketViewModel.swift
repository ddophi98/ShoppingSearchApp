// Copyright © 2023 com.template. All rights reserved.

import Domain
import Combine
import Foundation

final public class BasketViewModel: BaseViewModel {
    private let usecase: BasketUsecase
    @Published private(set) var contents = [ServerDrivenContentVO]()
    
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
}
