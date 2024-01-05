// Copyright © 2023 com.template. All rights reserved.

import RxSwift
import SnapKit
import UIKit

final public class TopFiveProductsBlock: UICollectionViewCell {
    static let id = "TopFiveProductsBlock"
    private var viewModel: ShoppingListViewModel?
    private var disposeBag = DisposeBag()
    
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
        title.font = .systemFont(ofSize: 20)
        return title
    }()
    lazy private var price: UILabel = {
        let price = UILabel()
        price.textAlignment = .center
        price.textColor = .gray
        price.font = .systemFont(ofSize: 18)
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
            make.width.height.equalTo(150)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(thumbnail.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
        }
        price.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func setCell(viewModel: ShoppingListViewModel, imageURL: String, title: String, price: Int) {
        self.viewModel = viewModel
        self.title.text = title.removeHtml()
        self.price.text = "\(price)원"
        viewModel.downloadImage(url: imageURL)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                thumbnail.image = UIImage(data: response)
            }, onFailure: { error in
                viewModel.setError(error: error)
            })
            .disposed(by: disposeBag)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        // 재사용하게 되면 다른 셀이 구독했던게 남아있으므로 명시적으로 구독 해제해주기
        disposeBag = DisposeBag()
    }
}
