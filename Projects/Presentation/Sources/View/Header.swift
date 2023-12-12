// Copyright © 2023 com.template. All rights reserved.

import UIKit

final public class Header: UICollectionReusableView {
    static let id = "Header"
    
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
        title.font = .boldSystemFont(ofSize: 30)
        return title
    }()
    
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()
    
    private func setView() {
        addSubview(title)
        title.addSubview(line)
    }
    
    private func setLayout() {
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalToSuperview()
        }
        line.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(8)
            make.height.equalTo(0.5)
            make.width.equalToSuperview()
        }
    }
    
    func setHeader(_ text: String) {
        title.text = text
    }
}
