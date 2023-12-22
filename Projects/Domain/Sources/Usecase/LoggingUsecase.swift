// Copyright © 2023 com.template. All rights reserved.

import Combine
import Foundation

public protocol LoggingUsecase {
    func loggingDetailViewAppeared()
    func loggingBasketViewAppeared()
    func loggingBasketViewTTI(logs: Dictionary<TTIPoint, Date>)
    func loggingShoppingListViewAppeared()
    func loggingShoppingListTTI(logs: Dictionary<TTIPoint, Date>)
    func loggingProductSearched(query: String)
    func loggingProductTapped(productName: String, productPrice: Int, productPosition: String, productIndex: Int)
}

final public class DefaultLoggingUsecase: LoggingUsecase {
    
    private let loggingRepository: LoggingRepository
    
    public init(loggingRepository: LoggingRepository) {
        self.loggingRepository = loggingRepository
    }
    
    public func loggingDetailViewAppeared() {
        let scheme = DetailViewAppeared.Builder().build()
        loggingRepository.shotLog(scheme)
    }
    
    public func loggingBasketViewAppeared() {
        let scheme = BasketViewAppeared.Builder().build()
        loggingRepository.shotLog(scheme)
    }
    
    public func loggingBasketViewTTI(logs: Dictionary<TTIPoint, Date>) {
        guard let loadViewTime = logs[.loadView],
              let drawViewTime = logs[.drawView],
              let sendRequestTime = logs[.sendRequest],
              let receiveResponseTime = logs[.receiveResponse],
              let bindDataTime = logs[.bindData],
              let drawCoreComponentTime = logs[.drawCoreComponent] else { return }
        
        let scheme = BasketViewTTI.Builder()
            .setTimeBetweenLoadViewAndDrawView(drawViewTime.timeIntervalSince(loadViewTime))
            .setTimeBetweenDrawViewAndSendRequest(sendRequestTime.timeIntervalSince(drawViewTime))
            .setTimeBetweenSendRequestAndReceiveResponse(receiveResponseTime.timeIntervalSince(sendRequestTime))
            .setTimeBetweenReceiveResponseAndBindData(bindDataTime.timeIntervalSince(receiveResponseTime))
            .setTimeBetweenBindDataAndDrawCoreComponent(drawCoreComponentTime.timeIntervalSince(bindDataTime))
            .build()
        loggingRepository.shotLog(scheme)
    }
    
    public func loggingShoppingListViewAppeared() {
        let scheme = ShoppingListViewAppeared.Builder().build()
        loggingRepository.shotLog(scheme)
    }
    
    public func loggingShoppingListTTI(logs: Dictionary<TTIPoint, Date>) {
        guard let loadViewTime = logs[.loadView],
              let drawViewTime = logs[.drawView],
              let sendRequestTime = logs[.sendRequest],
              let receiveResponseTime = logs[.receiveResponse],
              let bindDataTime = logs[.bindData],
              let drawCoreComponentTime = logs[.drawCoreComponent] else { return }
        
        let scheme = ShoppingListViewTTI.Builder()
            .setTimeBetweenLoadViewAndDrawView(drawViewTime.timeIntervalSince(loadViewTime))
            .setTimeBetweenDrawViewAndSendRequest(sendRequestTime.timeIntervalSince(drawViewTime))
            .setTimeBetweenSendRequestAndReceiveResponse(receiveResponseTime.timeIntervalSince(sendRequestTime))
            .setTimeBetweenReceiveResponseAndBindData(bindDataTime.timeIntervalSince(receiveResponseTime))
            .setTimeBetweenBindDataAndDrawCoreComponent(drawCoreComponentTime.timeIntervalSince(bindDataTime))
            .build()
        loggingRepository.shotLog(scheme)
    }
    
    public func loggingProductSearched(query: String) {
        let scheme = ShoppingProductSearched.Builder()
            .setQuery(query)
            .build()
        loggingRepository.shotLog(scheme)
    }
    
    public func loggingProductTapped(productName: String, productPrice: Int, productPosition: String, productIndex: Int) {
        let scheme = ShoppingProductTapped.Builder()
            .setProductName(productName)
            .setProductPrice(productPrice)
            .setProductPosition(productPosition)
            .setProductIndex(productIndex)
            .build()
        loggingRepository.shotLog(scheme)
    }
}
