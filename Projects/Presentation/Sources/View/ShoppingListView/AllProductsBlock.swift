// Copyright © 2023 com.template. All rights reserved.

import RxSwift
import SnapKit
import UIKit

final public class AllProductsBlock: UICollectionViewCell {
    static let id = "AllProductsBlock"
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
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    lazy private var title: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 20)
        return title
    }()
    lazy private var price: UILabel = {
        let price = UILabel()
        price.textAlignment = .left
        price.textColor = .gray
        price.font = .systemFont(ofSize: 18)
        return price
    }()
    
    private func setView() {
        addSubview(thumbnail)
        addSubview(stackView)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(price)
    }
    private func setLayout() {
        thumbnail.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(100)
        }
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(thumbnail.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
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
