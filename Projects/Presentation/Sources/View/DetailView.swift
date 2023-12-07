// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit

final public class DetailView: UIViewController {
    
    private let viewModel: DetailViewModel
    
    public init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setView()
        setLayout()
        setBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var text: UILabel = {
        let text = UILabel()
        text.text = "DetailView"
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
    
    private func setBinding() {
        
    }
    
    public func setCoordinator(_ coordinator: Coordinator) {
        viewModel.coordinator = coordinator
    }
}
