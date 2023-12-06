// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit

public class ShoppingListCellB: UICollectionViewCell {
   
    static let id = "ShoppingListCellB"
    static let cellHeight = 300.0
    static let cellWidth = 300.0
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
            make.width.height.equalTo(200)
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
    
    func setCell(imageURL: String, title: String, price: Int) {
        guard let viewModel = viewModel else { return }
        self.title.text = title.removeHtml()
        self.price.text = "\(price)원"
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
    
    func setViewModel(viewModel: ShoppingListViewModel) {
        self.viewModel = viewModel
    }
}
