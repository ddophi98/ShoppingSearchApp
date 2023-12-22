// Copyright © 2023 com.template. All rights reserved.

import Combine
import Domain
import Foundation

final public class ShoppingListViewModel: BaseViewModel {
    @Published private(set) var shoppingResultVO: ShoppingResultVO?
    @Published private(set) var sections = [ShoppingListSection]()
    
    private let productUsecase: ProductUsecase
    private let loggingUsecase: LoggingUsecase
    private var logsForTTI = Dictionary<TTIPoint, Date>()
    private var completeLoggingTTI = false
    
    public init(productUsecase: ProductUsecase, loggingUsecase: LoggingUsecase) {
        self.productUsecase = productUsecase
        self.loggingUsecase = loggingUsecase
    }
    
    enum ShoppingListSection {
        case TopFiveProducts([ShoppingItemVO])
        case AllProducts([ShoppingItemVO])
    }
    
    func searchShopping(query: String) {
        loggingProductSearched(query: query)
        productUsecase.searchShopping(query: query)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.setError(error: error)
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
                self?.loggingTTI(point: .receiveResponse)
            }
            .store(in: &cancellables)
    }
    
    func downloadImage(url: String) -> AnyPublisher<Data, Error> {
        productUsecase.downloadImage(url: url)
    }
    
    func moveToDetailView(item: ShoppingItemVO, position: String, index: Int) {
        loggingProductTapped(productName: item.title.removeHtml(), productPrice: item.lprice, productPosition: position, productIndex: index)
        coordinator?.moveToDetailView(item: item)
    }
    
    func setImageCache(url: String, data: Data) {
        productUsecase.setImageCache(url: url, data: data)
    }
    
    // --- logging ---
    func loggingViewAppeared() {
        loggingUsecase.loggingShoppingListViewAppeared()
    }
    
    private func loggingProductSearched(query: String) {
        loggingUsecase.loggingProductSearched(query: query)
    }
    
    private func loggingProductTapped(productName: String, productPrice: Int, productPosition: String, productIndex: Int) {
        loggingUsecase.loggingProductTapped(productName: productName, productPrice: productPrice, productPosition: productPosition, productIndex: productIndex)
    }
    
    func loggingTTI(point: TTIPoint) {
        if completeLoggingTTI {
            return
        }
        
        logsForTTI[point] = Date()
        if point == .drawCoreComponent {
            loggingUsecase.loggingShoppingListTTI(logs: logsForTTI)
            completeLoggingTTI = true
        }
    }
}
