// Copyright © 2024 com.shoppingSearch. All rights reserved.

@testable import Presentation
import XCTest
import Domain
import RxSwift

final class ShoppingListViewModelTest: BaseTestCase {
    let productUsecase = MockProductUsecase()
    let loggingUsecase = MockLoggingUsecase()
    let coordinator = MockFirstTabNavigation()
    lazy var viewModel = ShoppingListViewModel(
        productUsecase: productUsecase,
        loggingUsecase: loggingUsecase,
        coordinator: coordinator
    )
    
    // 상품의 개수가 5개 이상일 때, Top5 상품 섹션과 전체 상품 섹션 모두 만들어지는지 확인하기
    func testCreatingTwoSections() {
        given {            
            productUsecase.setSearchShoppingResult(ShoppingResultVO(
                lastBuildDate: "",
                total: -1,
                start: -1,
                display:-1,
                items: Array(repeating: ShoppingItemVO.sample, count: 6)
            ))
        }
        when {
            viewModel.searchShopping(query: "")
        }
        then {
            XCTAssertEqual(viewModel.sections.count, 2)
        }
    }
    
    // 상품의 개수가 5개 미만일 때, 전체 상품 섹션만 만들어지는지 확인하기
    func testCreatingOneSection() {
        given {
            productUsecase.setSearchShoppingResult(ShoppingResultVO(
                lastBuildDate: "",
                total: -1,
                start: -1,
                display:-1,
                items: Array(repeating: ShoppingItemVO.sample, count: 4)
            ))
        }
        when {
            viewModel.searchShopping(query: "")
        }
        then {
            XCTAssertEqual(viewModel.sections.count, 1)
        }
    }
    
    // 상품 목록이 변했을 때 Data Binding을 위해 신호를 보내는지 확인하기
    func testSendingSignalForDataBinding() {
        var receiveSignal: Bool = false
        var disposable: Disposable?
        
        given {
            disposable = viewModel.sectionsAreChanged
                .bind { _ in
                    receiveSignal = true
                }
        }
        when {
            viewModel.searchShopping(query: "")
        }
        then {
            XCTAssertTrue(receiveSignal)
            disposable?.dispose()
        }
    }
}
