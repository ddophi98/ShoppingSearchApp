// Copyright © 2023 com.shoppingSearch. All rights reserved.

import Foundation

public struct ShoppingListViewTTI: LoggingScheme {
    public var logVersion: Float = 1.0
    public var eventName: String = "Time To Interactive"
    public var screenName: String = "ShoppingList"
    public var logData: Array<(String, String)> = []
    
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
    
    public class Builder {
        
        private var timeBetweenLoadViewAndDrawView: Double?
        private var timeBetweenDrawViewAndSendRequest: Double?
        private var timeBetweenSendRequestAndReceiveResponse: Double?
        private var timeBetweenReceiveResponseAndBindData: Double?
        private var timeBetweenBindDataAndDrawCoreComponent: Double?
        
        public func setTimeBetweenLoadViewAndDrawView(_ time: Double) -> Builder {
            self.timeBetweenLoadViewAndDrawView = time
            return self
        }
        
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
            return ShoppingListViewTTI(
                timeBetweenLoadViewAndDrawView: timeBetweenLoadViewAndDrawView,
                timeBetweenDrawViewAndSendRequest: timeBetweenDrawViewAndSendRequest,
                timeBetweenSendRequestAndReceiveResponse: timeBetweenSendRequestAndReceiveResponse,
                timeBetweenReceiveResponseAndBindData: timeBetweenReceiveResponseAndBindData,
                timeBetweenBindDataAndDrawCoreComponent: timeBetweenBindDataAndDrawCoreComponent
            )
        }
    }
}
