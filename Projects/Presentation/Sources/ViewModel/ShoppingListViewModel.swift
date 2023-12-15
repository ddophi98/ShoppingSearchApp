// Copyright © 2023 com.template. All rights reserved.

import Combine
import Domain
import Foundation

final public class ShoppingListViewModel: BaseViewModel {
    @Published private(set) var shoppingResultVO: ShoppingResultVO?
    @Published private(set) var sections = [ShoppingListSection]()
    
    public let usecase: ShoppingListUsecase
    
    public init(usecase: ShoppingListUsecase) {
        self.usecase = usecase
    }
    
    enum ShoppingListSection {
        case TopFiveProducts([ShoppingItemVO])
        case AllProducts([ShoppingItemVO])
    }
    
    func searchShopping(query: String) {
        usecase.searchShopping(query: query)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                default:
                    break
                }
            } receiveValue: { [weak self] shoppingResultVO in
                self?.shoppingResultVO = shoppingResultVO
                self?.sections.removeAll()
                if shoppingResultVO.items.count >= 5 {
                    self?.sections.append(.TopFiveProducts(Array(shoppingResultVO.items.prefix(upTo: 5))))
                }
                self?.sections.append(.AllProducts(shoppingResultVO.items))
            }
            .store(in: &cancellables)
    }
    
    func downloadImage(url: String) -> AnyPublisher<Data, Error> {
        usecase.downloadImage(url: url)
    }
    
    func moveToDetailView(item: ShoppingItemVO) {
        coordinator?.moveToDetailView(item: item)
    }
    
    func setImageCache(url: String, data: Data) {
        usecase.setImageCache(url: url, data: data)
    }
}
