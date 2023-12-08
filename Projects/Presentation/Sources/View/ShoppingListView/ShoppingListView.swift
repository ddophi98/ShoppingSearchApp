// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit

final public class ShoppingListView: UIViewController {
    private let viewModel: ShoppingListViewModel
    
    public init(viewModel: ShoppingListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setView()
        setLayout()
        setBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        tableView.register(TopFiveBlock.self, forCellReuseIdentifier: TopFiveBlock.id)
        tableView.register(ShoppingListBlock.self, forCellReuseIdentifier: ShoppingListBlock.id)
        return tableView
    }()
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.searchShopping(query: "무선이어폰", display: 10)
    }
    
    private func setBinding() {
        viewModel.$shoppingResultVO
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shoppingResultVO in
                self?.tableView.reloadData()
            }
            .store(in: &viewModel.cancellable)
    }
    
    private func setView() {
        view.addSubview(tableView)
    }
    
    private func setLayout() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    public func setCoordinator(_ coordinator: Coordinator) {
        viewModel.coordinator = coordinator
    }
}

extension ShoppingListView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + (viewModel.allItems?.count ?? 0)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListBlock.id, for: indexPath) as! ShoppingListBlock
            cell.setViewModel(viewModel: viewModel)
            return cell
        } else {
            guard let item = viewModel.allItems?[indexPath.row-1] else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: TopFiveBlock.id, for: indexPath) as! TopFiveBlock
            cell.setViewModel(viewModel: viewModel)
            cell.setCell(imageURL: item.image, title: item.title, price: item.lprice)
            return cell
        }
    }
}

extension ShoppingListView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return ShoppingListCell.cellHeight + 100
        } else {
            return 250
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            guard let item = viewModel.allItems?[indexPath.row-1] else { return }
            viewModel.moveToDetailView(item: item)
        }
    }
}
