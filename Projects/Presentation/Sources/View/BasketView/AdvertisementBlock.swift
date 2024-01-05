// Copyright © 2023 com.template. All rights reserved.

import RxSwift
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
    
    func setCell(viewModel: BasketViewModel, imageURL: String, title: String) {
        self.viewModel = viewModel
        self.title.text = title
        viewModel.downloadImage(url: imageURL)
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

