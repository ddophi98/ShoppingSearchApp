// Copyright © 2024 com.shoppingSearch. All rights reserved.

@testable import Presentation
import XCTest
import Domain
import RxSwift

final class BasketViewModelTest: BaseTestCase {
    let productUsecase = MockProductUsecase()
    let loggingUsecase = MockLoggingUsecase()
    let coordinator = MockSecondTabNavigation()
    
    lazy var viewModel = BasketViewModel(
        productUsecase: productUsecase,
        loggingUsecase: loggingUsecase,
        coordinator: coordinator
    )
    
    // 장바구니 목록이 변했을 때 Data Binding을 위해 신호를 보내는지 확인하기
    func testSendingSignalForDataBinding() {
        var receiveSignal: Bool = false
        var disposable: Disposable?
        
        given {
            disposable = viewModel.contentsAreChanged
                .bind { _ in
                    receiveSignal = true
                }
        }
        when {
            viewModel.getBasketContents()
        }
        then {
            XCTAssertTrue(receiveSignal)
            disposable?.dispose()
        }
    }
}
