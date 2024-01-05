// Copyright © 2023 com.template. All rights reserved.

import UIKit

final public class ShoppingListHeader: UICollectionReusableView {
    static let id = "ShoppingListHeader"
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.font = .boldSystemFont(ofSize: 20)
        return title
    }()
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray2
        return line
    }()
    
    private func setView() {
        addSubview(title)
        title.addSubview(line)
    }
    private func setLayout() {
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(30)
        }
        line.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(8)
            make.height.equalTo(0.5)
        }
    }
    
    func setHeader(_ text: String) {
        title.text = text
    }
}
