// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit

public class ShoppingListCellA: UITableViewCell {
   
    private let viewModel: ShoppingListViewModel
    
    init(viewModel: ShoppingListViewModel) {
        self.viewModel = viewModel
        super.init(style: .default, reuseIdentifier: "ShoppingListCellA")
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
        return title
    }()
    
    lazy private var price: UILabel = {
        let price = UILabel()
        return price
    }()
    
    private func setView() {
        addSubview(thumbnail)
        addSubview(title)
        addSubview(price)
    }
    
    private func setLayout() {
        thumbnail.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.trailing.equalTo(50)
            make.height.equalTo(100)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(thumbnail.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        price.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func setCell(imageURL: String, title: String, lowPrice: Int, highPrice: Int) {
        self.title.text = title
        self.price.text = "\(lowPrice)~\(highPrice)"
        viewModel.downloadImage(url: imageURL)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                default:
                    break
                }
            } receiveValue: { [weak self] data in
                self?.thumbnail.image = UIImage(data: data)
            }
            .store(in: &viewModel.cancellable)
    }
}
