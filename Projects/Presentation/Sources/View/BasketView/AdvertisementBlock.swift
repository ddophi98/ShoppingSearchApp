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
    
    private func setView() {
        selectionStyle = .none
        addSubview(thumbnail)
        addSubview(title)
    }
    
    private func setLayout() {
        thumbnail.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(200)
        }
        title.snp.makeConstraints { make in
            make.leading.equalTo(thumbnail.snp.trailing).offset(20)
            make.width.equalTo(150)
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
            }
            .store(in: &viewModel.cancellables)
    }
    
    func setViewModel(viewModel: BasketViewModel) {
        self.viewModel = viewModel
    }
}

