// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit
import RxSwift

final public class RecentlyViewedCell: UICollectionViewCell {
   
    static let id = "RecentlyViewedCell"
    static let cellHeight = 150.0
    static let cellWidth = 100.0
    private var viewModel: BasketViewModel?
    private var idx: Int?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var thumbnail: UIImageView = {
        let thumbnail = UIImageView()
        thumbnail.contentMode = .scaleAspectFit
        return thumbnail
    }()
    
    lazy private var title: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 15)
        return title
    }()
    
    lazy private var price: UILabel = {
        let price = UILabel()
        price.textAlignment = .center
        price.textColor = .gray
        price.font = .systemFont(ofSize: 13)
        return price
    }()
    
    private func setView() {
        addSubview(thumbnail)
        addSubview(title)
        addSubview(price)
    }
    
    private func setLayout() {
        thumbnail.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(RecentlyViewedCell.cellWidth - 20)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(thumbnail.snp.bottom).offset(20)
            make.width.equalTo(RecentlyViewedCell.cellWidth)
            make.centerX.equalToSuperview()
        }
        price.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }

    func setCell(idx: Int, imageURL: String, title: String, price: Int) {
        guard let viewModel = viewModel else { return }
        
        self.idx = idx
        self.title.text = title.removeHtml()
        self.price.text = "\(price)원"
        viewModel.downloadImage(url: imageURL)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                thumbnail.image = UIImage(data: response)
                viewModel.setImageCache(url: imageURL, data: response)
            }, onFailure: { error in
                viewModel.setError(error: error)
            })
            .disposed(by: viewModel.disposeBag)
    }
    
    func setViewModel(viewModel: BasketViewModel) {
        self.viewModel = viewModel
    }
}
