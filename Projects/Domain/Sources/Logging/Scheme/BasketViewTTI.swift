// Copyright © 2023 com.shoppingSearch. All rights reserved.

struct BasketViewTTI: LoggingSchemeVO {
    let logVersion: Float = 1.0
    let eventName: String = "Time To Interactive"
    let screenName: String = "Basket"
    var logData: Array<(String, String)> = []
    
    private init(timeBetweenLoadViewAndDrawView: Double?, timeBetweenDrawViewAndSendRequest: Double?, timeBetweenSendRequestAndReceiveResponse: Double?, timeBetweenReceiveResponseAndBindData: Double?, timeBetweenBindDataAndDrawCoreComponent: Double?) {
        
        if let time = timeBetweenLoadViewAndDrawView {
            logData.append(("loadView <-> drawView", String(format: "%.4f", time)))
        }
        if let time = timeBetweenDrawViewAndSendRequest {
            logData.append(("drawView <-> sendRequest", String(format: "%.4f", time)))
        }
        if let time = timeBetweenSendRequestAndReceiveResponse {
            logData.append(("sendRequest <-> receiveResponse", String(format: "%.4f", time)))
        }
        if let time = timeBetweenReceiveResponseAndBindData {
            logData.append(("receiveResponse <-> bindData", String(format: "%.4f", time)))
        }
        if let time = timeBetweenBindDataAndDrawCoreComponent {
            logData.append(("bindData <-> drawCoreComponent", String(format: "%.4f", time)))
        }
    }
    
    final class Builder {
        private var timeBetweenLoadViewAndDrawView: Double?
        private var timeBetweenDrawViewAndSendRequest: Double?
        private var timeBetweenSendRequestAndReceiveResponse: Double?
        private var timeBetweenReceiveResponseAndBindData: Double?
        private var timeBetweenBindDataAndDrawCoreComponent: Double?
        
        func setTimeBetweenLoadViewAndDrawView(_ time: Double) -> Builder {
            timeBetweenLoadViewAndDrawView = time
            return self
        }
        func setTimeBetweenDrawViewAndSendRequest(_ time: Double) -> Builder {
            timeBetweenDrawViewAndSendRequest = time
            return self
        }
        func setTimeBetweenSendRequestAndReceiveResponse(_ time: Double) -> Builder {
            timeBetweenSendRequestAndReceiveResponse = time
            return self
        }
        func setTimeBetweenReceiveResponseAndBindData(_ time: Double) -> Builder {
            timeBetweenReceiveResponseAndBindData = time
            return self
        }
        func setTimeBetweenBindDataAndDrawCoreComponent(_ time: Double) -> Builder {
            timeBetweenBindDataAndDrawCoreComponent = time
            return self
        }
        
        func build() -> LoggingSchemeVO {
            return BasketViewTTI(
                timeBetweenLoadViewAndDrawView: timeBetweenLoadViewAndDrawView,
                timeBetweenDrawViewAndSendRequest: timeBetweenDrawViewAndSendRequest,
                timeBetweenSendRequestAndReceiveResponse: timeBetweenSendRequestAndReceiveResponse,
                timeBetweenReceiveResponseAndBindData: timeBetweenReceiveResponseAndBindData,
                timeBetweenBindDataAndDrawCoreComponent: timeBetweenBindDataAndDrawCoreComponent
            )
        }
    }
}
