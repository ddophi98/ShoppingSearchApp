// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit

final public class DetailView: UIViewController {
    
    private let viewModel: DetailViewModel
    
    public init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setView()
        setLayout()
        downloadImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loggingViewAppeared()
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
    
    private func setView() {
        view.backgroundColor = .white
        view.addSubview(productTitle)
        view.addSubview(thumbnail)
        view.addSubview(price)
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
    }
    
    private func downloadImage() {
        viewModel.downloadImage(url: viewModel.item.image)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                default:
                    break
                }
            } receiveValue: { [weak self] data in
                guard let self = self else { return }
                self.thumbnail.image = UIImage(data: data)
                self.viewModel.setImageCache(url: self.viewModel.item.image, data: data)
            }
            .store(in: &viewModel.cancellables)
    }
    
    public func setCoordinator(_ coordinator: Coordinator) {
        viewModel.coordinator = coordinator
    }
}
