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
        tableView.register(ShoppingListBlockB.self, forCellReuseIdentifier: ShoppingListBlockB.id)
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
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListBlockB.id, for: indexPath) as! ShoppingListBlockB
        cell.setViewModel(viewModel: viewModel)
        return cell
    }
}

extension ShoppingListView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ShoppingListCellB.cellHeight + 50
    }
}
