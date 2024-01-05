// Copyright © 2023 com.template. All rights reserved.

import RxSwift
import SnapKit
import UIKit

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
        viewModel.loggingLoadView()
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loggingDrawView()
        viewModel.getBasketContents()
    }
    
    lazy private var viewTitle: UILabel = {
        let viewTitle = UILabel()
        viewTitle.text = "장바구니"
        viewTitle.font = .boldSystemFont(ofSize: 30)
        return viewTitle
    }()
    lazy private var topLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray4
        return line
    }()
    lazy private var bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray4
        return line
    }()
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecentlyViewedBlock.self, forCellReuseIdentifier: RecentlyViewedBlock.id)
        tableView.register(WishListBlock.self, forCellReuseIdentifier: WishListBlock.id)
        tableView.register(AdvertisementBlock.self, forCellReuseIdentifier: AdvertisementBlock.id)
        tableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        return tableView
    }()
    lazy private var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.font = .boldSystemFont(ofSize: 40)
        errorLabel.textColor = .white
        errorLabel.backgroundColor = .init(white: 0.0, alpha: 0.5)
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        return errorLabel
    }()

    private func setBinding() {
        viewModel.contentsAreChanged
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
                guard let self = self else { return }
                tableView.reloadData()
                viewModel.loggingBindData()
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
            cell.setItems(viewModel: viewModel, items: recentlyViewedVOs)
            return cell
        case .WishList(let wishListVO):
            let cell = tableView.dequeueReusableCell(withIdentifier: WishListBlock.id) as! WishListBlock
            cell.setCell(viewModel: viewModel, title: wishListVO.title, price: wishListVO.price)
            return cell
        case .Advertisement(let advertisementVO):
            let cell = tableView.dequeueReusableCell(withIdentifier: AdvertisementBlock.id) as! AdvertisementBlock
            cell.setCell(viewModel: viewModel, imageURL: advertisementVO.image, title: advertisementVO.text)
            return cell
        }
    }
}

extension BasketView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let content = viewModel.contents[indexPath.row]
        switch content {
        case .RecentlyViewed:
            return 250
        case .WishList:
            return 80
        case .Advertisement:
            return 170
        }
    }
}
