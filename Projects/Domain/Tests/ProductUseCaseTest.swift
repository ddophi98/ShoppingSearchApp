// Copyright © 2024 com.shoppingSearch. All rights reserved.

@testable import Domain
import XCTest
import RxSwift

final class ProductUseCaseTest: BaseTestCase {

    let serverDrivenRepository = MockServerDrivenRepository()
    let imageRepository = MockImageRepository()
    let searchRepository = MockSearchRepository()
    
    lazy var usecase = DefaultProductUsecase(
        serverDrivenRepository: serverDrivenRepository,
        imageRepository: imageRepository,
        searchRepository: searchRepository
    )
    
    // 상품의 개수가 5개 이상일 때, Top5 상품 섹션과 전체 상품 섹션 모두 만들어지는지 확인하기
    func testCreatingTwoSections() {
        var result: Int?
        var disposable: Disposable?
        
        given {
            searchRepository.setSearchShoppingResult(ShoppingResultVO(
                lastBuildDate: "",
                total: -1,
                start: -1,
                display:-1,
                items: Array(repeating: ShoppingItemVO.sample, count: 6)
            ))
        }
        when {
            disposable = usecase.searchShopping(query: "")
                .subscribe( onSuccess: {  response in
                    result = response.count
                })
        }
        then {
            XCTAssertEqual(result, 2)
            disposable?.dispose()
        }
    }

    // 상품의 개수가 5개 미만일 때, 전체 상품 섹션만 만들어지는지 확인하기
    func testCreatingOneSection() {
        var result: Int?
        var disposable: Disposable?
        
        given {
            searchRepository.setSearchShoppingResult(ShoppingResultVO(
                lastBuildDate: "",
                total: -1,
                start: -1,
                display:-1,
                items: Array(repeating: ShoppingItemVO.sample, count: 4)
            ))
        }
        when {
            disposable = usecase.searchShopping(query: "")
                .subscribe( onSuccess: {  response in
                    result = response.count
                })
        }
        then {
            XCTAssertEqual(result, 1)
            disposable?.dispose()
        }
    }
}
