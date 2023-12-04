// Copyright © 2023 com.template. All rights reserved.

import Combine
import Domain
import Foundation

final public class RandomCatViewModel: BaseViewModel {
    @Published private(set) var catImageVO: [CatImageVO]?
    @Published private(set) var catImage: Data?
    public let usecase: RandomCatUsecase
    
    public init(usecase: RandomCatUsecase) {
        self.usecase = usecase
    }
    
    func loadCatImage() {
        usecase.loadCatImage()
            .receive(on: DispatchQueue.main)
            .sink {  completion in
                switch completion {
                case .failure(let error):
                    print(error)
                default: break
                }
            } receiveValue: { catImageVO in
                self.catImageVO = catImageVO
                if !catImageVO.isEmpty {
                    self.getImageData(url: catImageVO[0].url)
                }
            }
            .store(in: &cancellable)
    }
    
    private func getImageData(url: String) {
        usecase.download(url: url)
            .receive(on: DispatchQueue.main)
            .sink {  completion in
                switch completion {
                case .failure(let error):
                    print(error)
                default: break
                }
            } receiveValue: { data in
                self.catImage = data
            }
            .store(in: &cancellable)
    }
}
