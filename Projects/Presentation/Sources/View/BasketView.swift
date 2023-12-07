// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit

final public class BasketView: UIViewController {
    
    private let viewModel: BasketViewModel
    
    public init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var text: UILabel = {
        let text = UILabel()
        text.text = "MyBasket"
        return text
    }()
    
    private func setView() {
        view.backgroundColor = .white
        view.addSubview(text)
    }
    
    private func setLayout() {
        text.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
