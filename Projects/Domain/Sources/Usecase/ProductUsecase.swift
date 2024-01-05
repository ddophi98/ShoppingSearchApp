// Copyright © 2023 com.template. All rights reserved.

import Foundation
import RxSwift

public protocol ProductUsecase {
    func searchShopping(query: String) -> Single<ShoppingResultVO>
    func getBasketContents() -> Single<[ServerDrivenContentVO]>
    func downloadImage(url: String) -> Single<Data>
}

final public class DefaultProductUsecase: ProductUsecase {
    private let serverDrivenRepository: ServerDrivenRepository
    private let imageRepository: ImageRepository
    private let searchRepository: SearchRepository
    
    public init(serverDrivenRepository: ServerDrivenRepository, imageRepository: ImageRepository, searchRepository: SearchRepository) {
        self.serverDrivenRepository = serverDrivenRepository
        self.imageRepository = imageRepository
        self.searchRepository = searchRepository
    }
    
    public func getBasketContents() -> Single<[ServerDrivenContentVO]> {
        serverDrivenRepository.getBasketContents()
    }
    public func downloadImage(url: String) -> Single<Data> {
        imageRepository.downloadImage(url: url)
    }
    public func searchShopping(query: String) -> Single<ShoppingResultVO> {
        searchRepository.searchShopping(query: query)
    }
}
