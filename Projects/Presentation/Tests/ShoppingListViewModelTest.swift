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
