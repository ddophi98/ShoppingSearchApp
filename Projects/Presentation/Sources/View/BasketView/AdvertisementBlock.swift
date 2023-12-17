// Copyright © 2023 com.template. All rights reserved.

import UIKit

final public class AdvertisementBlock: UITableViewCell {
    static let id = "AdvertisementBlock"
    private var viewModel: BasketViewModel?
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var advertisementLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "⚠️ 광고"
        return label
    }()
    
    lazy private var thumbnail: UIImageView = {
        let thumbnail = UIImageView()
        thumbnail.contentMode = .scaleAspectFit
        return thumbnail
    }()
    
    lazy private var title: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 15)
        title.numberOfLines = 3
        return title
    }()
    
    private func setView() {
        backgroundColor = .systemMint
        selectionStyle = .none
        addSubview(advertisementLabel)
        addSubview(thumbnail)
        addSubview(title)
    }
    
    private func setLayout() {
        advertisementLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
        }
        
        thumbnail.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(advertisementLabel.snp.bottom).offset(10)
            make.width.height.equalTo(100)
        }
        title.snp.makeConstraints { make in
            make.leading.equalTo(thumbnail.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
    }
    
    func setCell(imageURL: String, title: String) {
        guard let viewModel = viewModel else { return }
        self.title.text = title
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
                viewModel.setImageCache(url: imageURL, data: data)
            }
            .store(in: &viewModel.cancellables)
    }
    
    func setViewModel(viewModel: BasketViewModel) {
        self.viewModel = viewModel
    }
}

