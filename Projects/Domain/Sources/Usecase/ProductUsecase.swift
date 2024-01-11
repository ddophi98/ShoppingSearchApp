// Copyright © 2023 com.template. All rights reserved.

import Foundation
import RxSwift

public enum ShoppingListSection {
    case TopFiveProducts([ShoppingItemVO])
    case AllProducts([ShoppingItemVO])
}

public protocol ProductUsecase {
    func searchShopping(query: String) -> Single<[ShoppingListSection]>
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
    public func searchShopping(query: String) -> Single<[ShoppingListSection]> {
        searchRepository.searchShopping(query: query)
            .flatMap { shoppingResultVO in
                var sections = [ShoppingListSection]()
                // 상품이 5개가 넘는다면 Top5 상품 섹션도 보여주기
                if shoppingResultVO.items.count >= 5 {
                    sections.append(.TopFiveProducts(Array(shoppingResultVO.items.prefix(upTo: 5))))
                }
                sections.append(.AllProducts(shoppingResultVO.items))
                return Single.just(sections)
            }
    }
}
