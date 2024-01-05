// Copyright © 2023 com.template. All rights reserved.

import Combine
import Domain
import Foundation
import RxSwift
import RxCocoa

enum ShoppingListSection {
    case TopFiveProducts([ShoppingItemVO])
    case AllProducts([ShoppingItemVO])
}

final public class ShoppingListViewModel: BaseViewModel {
    private let productUsecase: ProductUsecase
    private let loggingUsecase: LoggingUsecase
    private let coordinator: FirstTabNavigation
    private var logsForTTI = Dictionary<TTIPoint, Date>()
    private var completeLoggingTTI = false
    
    private(set) var sections = [ShoppingListSection]()
    let sectionsAreChanged = PublishRelay<Void>()
    
    public init(productUsecase: ProductUsecase, loggingUsecase: LoggingUsecase, coordinator: FirstTabNavigation) {
        self.productUsecase = productUsecase
        self.loggingUsecase = loggingUsecase
        self.coordinator = coordinator
    }
    
    func searchShopping(query: String) {
        loggingProductSearched(query: query)
        loggingSendRequest()
        productUsecase.searchShopping(query: query)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                var newSections = [ShoppingListSection]()
                // 상품이 5개가 넘는다면 Top5 상품 섹션도 보여주기
                if response.items.count >= 5 {
                    newSections.append(.TopFiveProducts(Array(response.items.prefix(upTo: 5))))
                }
                newSections.append(.AllProducts(response.items))
                sections = newSections
                sectionsAreChanged.accept(())
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
    func moveToDetailView(item: ShoppingItemVO, position: String, index: Int) {
        loggingProductTapped(productName: item.title.removeHtml(), productPrice: item.lprice, productPosition: position, productIndex: index)
        coordinator.moveToDetailView(item: item)
    }
    
    // --- 로깅 관련 메소드 ---
    func loggingLoadView() {
        loggingTTI(point: .loadView)
    }
    func loggingDrawView() {
        loggingUsecase.loggingShoppingListViewAppeared()
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
    private func loggingProductSearched(query: String) {
        loggingUsecase.loggingProductSearched(query: query)
    }
    private func loggingProductTapped(productName: String, productPrice: Int, productPosition: String, productIndex: Int) {
        loggingUsecase.loggingProductTapped(productName: productName, productPrice: productPrice, productPosition: productPosition, productIndex: productIndex)
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
