// Copyright © 2023 com.template. All rights reserved.

import Combine
import Domain
import Foundation
import RxSwift
import RxCocoa

final public class ShoppingListViewModel: BaseViewModel {
    private let productUsecase: ProductUsecase
    private let loggingUsecase: LoggingUsecase
    
    private var logsForTTI = Dictionary<TTIPoint, Date>()
    private var completeLoggingTTI = false
    private(set) var sections = [ShoppingListSection]()
    let sectionsChangedRelay = PublishRelay<Bool>()
    
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
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                var newSections = [ShoppingListSection]()
                if response.items.count >= 5 {
                    newSections.append(.TopFiveProducts(Array(response.items.prefix(upTo: 5))))
                }
                newSections.append(.AllProducts(response.items))
                sections = newSections
                sectionsChangedRelay.accept(true)
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
