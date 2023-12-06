// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit

public class ShoppingListView: UIViewController {
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
        tableView.register(ShoppingListBlock1.self, forCellReuseIdentifier: ShoppingListBlock1.id)
        tableView.register(ShoppingListBlock2.self, forCellReuseIdentifier: ShoppingListBlock2.id)
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
}

extension ShoppingListView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + (viewModel.allItems?.count ?? 0)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListBlock2.id, for: indexPath) as! ShoppingListBlock2
            cell.setViewModel(viewModel: viewModel)
            return cell
        } else {
            guard let item = viewModel.allItems?[indexPath.row-1] else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListBlock1.id, for: indexPath) as! ShoppingListBlock1
            cell.setViewModel(viewModel: viewModel)
            cell.setCell(imageURL: item.image, title: item.title, price: item.lprice)
            return cell
        }
    }
}

extension ShoppingListView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return ShoppingListCellForBlock2.cellHeight + 100
        } else {
            return 250
        }
    }
}
