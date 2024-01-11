// Copyright © 2024 com.shoppingSearch. All rights reserved.

import Foundation
import RxSwift

final class MockImageRepository: ImageRepository {
    private var downloadImageResult: Data?
    
    func setDownloadImageResult(_ downloadImageResult: Data?) {
        self.downloadImageResult = downloadImageResult
    }
    
    func downloadImage(url: String) -> Single<Data> {
        if let result = downloadImageResult {
            return Single.just(result)
        } else {
            return Single.just(Data())
        }
    }
}
