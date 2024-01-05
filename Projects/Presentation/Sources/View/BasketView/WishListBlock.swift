// Copyright © 2023 com.template. All rights reserved.

import UIKit

final public class WishListBlock: UITableViewCell {
    static let id = "WishListBlock"
    private var viewModel: BasketViewModel?
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var title: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 15)
        return title
    }()
    lazy private var price: UILabel = {
        let price = UILabel()
        price.textAlignment = .left
        price.textColor = .gray
        price.font = .systemFont(ofSize: 13)
        return price
    }()
    
    private func setView() {
        selectionStyle = .none
        addSubview(title)
        addSubview(price)
    }
    private func setLayout() {
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(20)
        }
        price.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(title.snp.bottom).offset(10)
        }
    }

    func setCell(viewModel: BasketViewModel, title: String, price: Int) {
        self.viewModel = viewModel
        self.title.text = title
        self.price.text = "\(price)원"
    }
}
