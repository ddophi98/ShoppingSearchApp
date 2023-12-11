// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit
import Domain

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
    
    lazy private var collectionView: UICollectionView = {
        let collectionViewFlowLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 8.0
            layout.itemSize = .init(width: TopFiveProductsCell.cellWidth, height: TopFiveProductsCell.cellHeight)
            return layout
        }()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(AllProductsBlock.self, forCellWithReuseIdentifier: AllProductsBlock.id)
        collectionView.register(TopFiveProductsCell.self, forCellWithReuseIdentifier: TopFiveProductsCell.id)
        return collectionView
    }()
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.searchShopping(query: "무선이어폰", display: 10)
    }
    
    private func setBinding() {
        viewModel.$sections
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func setView() {
        view.addSubview(collectionView)
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    public func setCoordinator(_ coordinator: Coordinator) {
        viewModel.coordinator = coordinator
    }
}

extension ShoppingListView: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .AllProducts(let items):
            return items.count
        case .TopFiveProducts(let items):
            return items.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .AllProducts(let items):
            let item = items[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllProductsBlock.id, for: indexPath) as! AllProductsBlock
            cell.setViewModel(viewModel: viewModel)
            cell.setCell(imageURL: item.image, title: item.title, price: item.lprice)
            return cell
        case .TopFiveProducts(let items):
            let item = items[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopFiveProductsCell.id, for: indexPath) as! TopFiveProductsCell
            cell.setViewModel(viewModel: viewModel)
            cell.setCell(idx: indexPath.item, imageURL: item.image, title: item.title, price: item.lprice)
            return cell
        }
    }
    
    
}

extension ShoppingListView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TopFiveProductsCell.cellHeight + 100
        } else {
            return 250
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            guard let item = viewModel.shoppingResultVO?.items[indexPath.row-1] else { return }
            viewModel.moveToDetailView(item: item)
        }
    }
}
