// Copyright © 2023 com.shoppingSearch. All rights reserved.

public protocol LoggingSchemeVO {
    // --- 모든 로그에 공통적으로 들어갈 요소 (값은 다를 수 있음) ---
    var logVersion: Float { get }
    var eventName: String { get }
    var screenName: String { get }
    
    // --- 로그마다 특화된 값을 저장해놓는 배열 (딕셔너리도 가능, 하지만 그렇게 하면 순서 보장 안됨) ---
    var logData: Array<(String, String)> { get set }
}
