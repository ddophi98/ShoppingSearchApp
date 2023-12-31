// Copyright © 2023 com.template. All rights reserved.

import RxSwift
import SnapKit
import UIKit

final public class DetailView: UIViewController {
    private let viewModel: DetailViewModel
    
    public init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setView()
        setLayout()
        setBinding()
        downloadImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loggingDrawView()
    }
    
    lazy private var productTitle: UILabel = {
        let productTitle = UILabel()
        productTitle.textAlignment = .center
        productTitle.font = .boldSystemFont(ofSize: 20)
        productTitle.numberOfLines = 0
        productTitle.text = viewModel.item.title.removeHtml()
        return productTitle
    }()
    lazy private var thumbnail: UIImageView = {
        let thumbnail = UIImageView()
        thumbnail.contentMode = .scaleAspectFit
        return thumbnail
    }()
    lazy private var price: UILabel = {
        let price = UILabel()
        price.textAlignment = .left
        price.textColor = .gray
        price.font = .systemFont(ofSize: 18)
        price.text = "\(viewModel.item.lprice)원"
        return price
    }()
    lazy private var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.font = .boldSystemFont(ofSize: 40)
        errorLabel.textColor = .white
        errorLabel.backgroundColor = .init(white: 0.0, alpha: 0.5)
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        return errorLabel
    }()
    
    private func setBinding() {
        viewModel.errorRelay
            .observe(on: MainScheduler.instance)
            .bind { [weak self] errorString in
                guard let self = self else { return }
                errorLabel.text = errorString
                errorLabel.isHidden = false
            }
            .disposed(by: viewModel.disposeBag)
    }
    private func setView() {
        view.backgroundColor = .white
        view.addSubview(productTitle)
        view.addSubview(thumbnail)
        view.addSubview(price)
        view.addSubview(errorLabel)
    }
    private func setLayout() {
        productTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        thumbnail.snp.makeConstraints { make in
            make.top.equalTo(productTitle.snp.bottom).offset(20)
            make.width.height.equalTo(300)
            make.centerX.equalToSuperview()
        }
        price.snp.makeConstraints { make in
            make.top.equalTo(thumbnail.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        errorLabel.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    private func downloadImage() {
        viewModel.downloadImage(url: viewModel.item.image)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                thumbnail.image = UIImage(data: response)
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                viewModel.setError(error: error)
            })
            .disposed(by: viewModel.disposeBag)
    }
}
