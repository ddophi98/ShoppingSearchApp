// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit
import RxSwift

final public class AllProductsBlock: UICollectionViewCell {
    
    static let id = "AllProductsBlock"
    private var viewModel: ShoppingListViewModel?
    
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
    
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
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
    
    func setCell(imageURL: String, title: String, price: Int) {
        guard let viewModel = viewModel else { return }
        self.title.text = title.removeHtml()
        self.price.text = "\(price)원"
        viewModel.downloadImage(url: imageURL)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                thumbnail.image = UIImage(data: response)
                viewModel.setImageCache(url: imageURL, data: response)
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                viewModel.setError(error: error)
            })
            .disposed(by: viewModel.disposeBag)
    }
    
    func setViewModel(viewModel: ShoppingListViewModel) {
        self.viewModel = viewModel
    }
}
