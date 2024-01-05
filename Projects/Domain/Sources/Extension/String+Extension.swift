// Copyright © 2023 com.template. All rights reserved.

extension String {
    public func removeHtml() -> String {
        return self.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
    }
}
