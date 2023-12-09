// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit

final public class TopFiveCell: UICollectionViewCell {
   
    static let id = "TopFiveCell"
    static let cellHeight = 300.0
    static let cellWidth = 300.0
    private var viewModel: ShoppingListViewModel?
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
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_:))))
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
    
    @objc private func tapped(_ sender: UITapGestureRecognizer) {
        guard let idx = idx,
              let item = viewModel?.top5Items?[idx] else { return }
        viewModel?.moveToDetailView(item: item)
    }
    
    func setCell(idx: Int, imageURL: String, title: String, price: Int) {
        guard let viewModel = viewModel else { return }
        
        self.idx = idx
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
            .store(in: &viewModel.cancellables)
    }
    
    func setViewModel(viewModel: ShoppingListViewModel) {
        self.viewModel = viewModel
    }
}