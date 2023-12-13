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
        setBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var viewTitle: UILabel = {
        let viewTitle = UILabel()
        viewTitle.text = "장바구니"
        viewTitle.font = .boldSystemFont(ofSize: 30)
        return viewTitle
    }()
    
    private lazy var line: UIView = {
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
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getBasketContents()
    }
    
    private func setView() {
        view.backgroundColor = .white
        view.addSubview(viewTitle)
        view.addSubview(line)
        view.addSubview(tableView)
    }
    
    private func setLayout() {
        viewTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        line.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top)
            make.height.equalTo(0.5)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setBinding() {
        viewModel.$contents
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &viewModel.cancellables)
    }
    
    public func setCoordinator(_ coordinator: Coordinator) {
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
            return 250
        }
    }
}
