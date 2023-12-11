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
    
    private lazy var collectionViewLayout = UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
        switch self.viewModel.sections[section] {
        case .AllProducts:
            // item
            let itemInset: CGFloat = 2.5
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
            
            // Group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
            return section
        case .TopFiveProducts:
            // item
            let itemInset: CGFloat = 2.5
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
            
            // Group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
            section.orthogonalScrollingBehavior = .continuous
            return section
            
        }
    }
    
    
    lazy private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(AllProductsBlock.self, forCellWithReuseIdentifier: AllProductsBlock.id)
        collectionView.register(TopFiveProductsBlock.self, forCellWithReuseIdentifier: TopFiveProductsBlock.id)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopFiveProductsBlock.id, for: indexPath) as! TopFiveProductsBlock
            cell.setViewModel(viewModel: viewModel)
            cell.setCell(idx: indexPath.item, imageURL: item.image, title: item.title, price: item.lprice)
            return cell
        }
    }
    
    
}

extension ShoppingListView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TopFiveProductsBlock.cellHeight + 100
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
