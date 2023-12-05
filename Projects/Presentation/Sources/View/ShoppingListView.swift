// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit

public class ShoppingListView: UIViewController {
    private let viewModel: ShoppingListViewModel
    
    public init(viewModel: ShoppingListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        return tableView
    }()
    
    public override func viewDidLoad() {
        setView()
        setLayout()
        setBinding()
    }
    
    private func setBinding() {
        viewModel.$shoppingResultVO
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &viewModel.cancellable)
    }
    
    private func setView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func setLayout() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.searchShopping(query: "무선이어폰", display: 10)
    }
}

extension ShoppingListView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.shoppingResultVO?.items.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel.shoppingResultVO?.items[indexPath.row] else { return UITableViewCell() }
        
        let cell = ShoppingListCellA(viewModel: viewModel)
        cell.setCell(imageURL: item.image, title: item.title, lowPrice: item.lprice, highPrice: item.hprice)
        return cell
    }
}
