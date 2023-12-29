// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit
import RxSwift

final public class BasketView: UIViewController {
    
    private let viewModel: BasketViewModel
    
    public init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setView()
        setLayout()
        setBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loggingTTI(point: .loadView)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loggingViewAppeared()
        viewModel.loggingTTI(point: .drawView)
        viewModel.getBasketContents()
        viewModel.loggingTTI(point: .sendRequest)
    }
    
    private lazy var viewTitle: UILabel = {
        let viewTitle = UILabel()
        viewTitle.text = "장바구니"
        viewTitle.font = .boldSystemFont(ofSize: 30)
        return viewTitle
    }()
    
    private lazy var topLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray4
        return line
    }()
    
    private lazy var bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray4
        return line
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecentlyViewedBlock.self, forCellReuseIdentifier: RecentlyViewedBlock.id)
        tableView.register(WishListBlock.self, forCellReuseIdentifier: WishListBlock.id)
        tableView.register(AdvertisementBlock.self, forCellReuseIdentifier: AdvertisementBlock.id)
        tableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        return tableView
    }()
    
    private lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.font = .boldSystemFont(ofSize: 40)
        errorLabel.textColor = .white
        errorLabel.backgroundColor = .init(white: 0.0, alpha: 0.5)
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        return errorLabel
    }()

    private func setView() {
        view.backgroundColor = .white
        view.addSubview(viewTitle)
        view.addSubview(topLine)
        view.addSubview(bottomLine)
        view.addSubview(tableView)
        view.addSubview(errorLabel)
    }
    
    private func setLayout() {
        viewTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        topLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top)
            make.height.equalTo(0.5)
        }
        bottomLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(tableView.snp.bottom)
            make.height.equalTo(0.5)
        }
        errorLabel.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func setBinding() {
        viewModel.contentsAreChanged
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
                guard let self = self else { return }
                tableView.reloadData()
                viewModel.loggingTTI(point: .bindData)
            }
            .disposed(by: viewModel.disposeBag)
        
        viewModel.errorRelay
            .observe(on: MainScheduler.instance)
            .bind { [weak self] errorString in
                guard let self = self else { return }
                errorLabel.text = errorString
                errorLabel.isHidden = false
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    public func setCoordinator(_ coordinator: SecondTabNavigation) {
        viewModel.coordinator = coordinator
    }
}

extension BasketView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contents.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = viewModel.contents[indexPath.row]
        switch content {
        case .RecentlyViewed(let recentlyViewedVOs):
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentlyViewedBlock.id) as! RecentlyViewedBlock
            cell.setViewModel(viewModel: viewModel)
            cell.setItems(items: recentlyViewedVOs)
            return cell
        case .WishList(let wishListVO):
            let cell = tableView.dequeueReusableCell(withIdentifier: WishListBlock.id) as! WishListBlock
            cell.setViewModel(viewModel: viewModel)
            cell.setCell(title: wishListVO.title, price: wishListVO.price)
            return cell
        case .Advertisement(let advertisementVO):
            let cell = tableView.dequeueReusableCell(withIdentifier: AdvertisementBlock.id) as! AdvertisementBlock
            cell.setViewModel(viewModel: viewModel)
            cell.setCell(imageURL: advertisementVO.image, title: advertisementVO.text)
            return cell
        }
    }
}

extension BasketView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let content = viewModel.contents[indexPath.row]
        switch content {
        case .RecentlyViewed:
            return RecentlyViewedCell.cellHeight + 100
        case .WishList:
            return 80
        case .Advertisement:
            return 170
        }
    }
}
