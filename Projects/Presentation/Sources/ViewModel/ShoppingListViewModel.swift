// Copyright © 2023 com.template. All rights reserved.

import Combine
import Domain
import Foundation

final public class ShoppingListViewModel: BaseViewModel {
    @Published private(set) var shoppingResultVO: ShoppingResultVO?
    @Published private(set) var allItems: [ShoppingItemVO]?
    @Published private(set) var top5Items: [ShoppingItemVO]?
    public let usecase: ShoppingListUsecase
    
    public init(usecase: ShoppingListUsecase) {
        self.usecase = usecase
    }
    
    func searchShopping(query: String, display: Int) {
        usecase.searchShopping(query: query, display: display)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                default:
                    break
                }
            } receiveValue: { [weak self] shoppingResultVO in
                self?.shoppingResultVO = shoppingResultVO
                self?.allItems = shoppingResultVO.items
                self?.top5Items = Array(shoppingResultVO.items.prefix(upTo: 5))
            }
            .store(in: &cancellable)
    }
    
    func downloadImage(url: String) -> AnyPublisher<Data, Error> {
        usecase.downloadImage(url: url)
    }
    
    func moveToDetailView(item: ShoppingItemVO) {
        coordinator?.moveToDetailView(item: item)
    }
}
