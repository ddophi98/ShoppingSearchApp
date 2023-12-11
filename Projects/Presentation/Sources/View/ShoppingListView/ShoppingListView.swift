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
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0 / 4.0)
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            return section
            
        case .TopFiveProducts:
            // item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(300)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
            
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
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
        view.backgroundColor = .white
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

extension ShoppingListView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.sections[indexPath.section] {
        case .AllProducts(let items):
            viewModel.moveToDetailView(item: items[indexPath.item])
        case .TopFiveProducts(let items):
            viewModel.moveToDetailView(item: items[indexPath.item])
        }
    }
}
