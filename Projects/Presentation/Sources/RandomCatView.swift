// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit

public class RandomCatView: UIViewController {
    private let viewModel: RandomCatViewModel
    
    private lazy var myTitle: UILabel = {
        let title = UILabel()
        title.text = "Random Cat"
        return title
    }()
    private lazy var myImage: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        return imageView
    }()
    
    public init(viewModel: RandomCatViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        setView()
        setLayout()
        setBinding()
        viewModel.loadCatImage()
    }
    
    private func setBinding() {
        viewModel.$catImage
            .receive(on: DispatchQueue.main)
            .sink { data in
                if let data = data {
                    self.myImage.image = UIImage(data: data)
                }
            }
            .store(in: &viewModel.cancellable)
    }
    
    private func setView() {
        view.backgroundColor = .white
        view.addSubview(myTitle)
        view.addSubview(myImage)
    }
    
    private func setLayout() {
        myTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        myImage.snp.makeConstraints { make in
            make.top.equalTo(myTitle.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.lessThanOrEqualTo(200)
        }
    }
}
