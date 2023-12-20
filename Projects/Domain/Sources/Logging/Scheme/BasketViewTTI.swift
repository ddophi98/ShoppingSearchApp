// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation

public struct BasketViewTTI: LoggingScheme {
    public var logVersion: Float = 1.0
    public var eventName: String = "Time To Interactive"
    public var screenName: String = "Basket"
    public var logData: Array<(String, String)> = []
    
    private init(timeBetweenDrawViewAndSendRequest: Double?, timeBetweenSendRequestAndReceiveResponse: Double?, timeBetweenReceiveResponseAndBindData: Double?, timeBetweenBindDataAndDrawCoreComponent: Double?) {
        
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
    
    public class Builder {
        
        private var timeBetweenDrawViewAndSendRequest: Double?
        private var timeBetweenSendRequestAndReceiveResponse: Double?
        private var timeBetweenReceiveResponseAndBindData: Double?
        private var timeBetweenBindDataAndDrawCoreComponent: Double?

        public func setTimeBetweenDrawViewAndSendRequest(_ time: Double) -> Builder {
            self.timeBetweenDrawViewAndSendRequest = time
            return self
        }
        
        public func setTimeBetweenSendRequestAndReceiveResponse(_ time: Double) -> Builder {
            self.timeBetweenSendRequestAndReceiveResponse = time
            return self
        }
        
        public func setTimeBetweenReceiveResponseAndBindData(_ time: Double) -> Builder {
            self.timeBetweenReceiveResponseAndBindData = time
            return self
        }
        
        public func setTimeBetweenBindDataAndDrawCoreComponent(_ time: Double) -> Builder {
            self.timeBetweenBindDataAndDrawCoreComponent = time
            return self
        }
        
        public func build() -> LoggingScheme {
            return BasketViewTTI(
                timeBetweenDrawViewAndSendRequest: timeBetweenDrawViewAndSendRequest,
                timeBetweenSendRequestAndReceiveResponse: timeBetweenSendRequestAndReceiveResponse,
                timeBetweenReceiveResponseAndBindData: timeBetweenReceiveResponseAndBindData,
                timeBetweenBindDataAndDrawCoreComponent: timeBetweenBindDataAndDrawCoreComponent
            )
        }
    }
}
