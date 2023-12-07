// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit

final public class ShoppingListBlock2: UITableViewCell {
    
    static let id = "ShoppingListBlock2"
    private var viewModel: ShoppingListViewModel?
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var title: UILabel = {
        let title = UILabel()
        title.text = "Top 5 Products"
        title.font = .systemFont(ofSize: 30)
        return title
    }()
    
    lazy private var collectionView: UICollectionView = {
        let collectionViewFlowLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 8.0
            layout.itemSize = .init(width: ShoppingListCellForBlock2.cellWidth, height: ShoppingListCellForBlock2.cellHeight)
            return layout
        }()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(ShoppingListCellForBlock2.self, forCellWithReuseIdentifier: ShoppingListCellForBlock2.id)
        return collectionView
    }()
    
    private func setBinding(viewModel: ShoppingListViewModel) {
        viewModel.$top5Items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shoppingResultVO in
                self?.collectionView.reloadData()
            }
            .store(in: &viewModel.cancellable)
    }
    
    private func setView() {
        backgroundColor = .systemGray6
        addSubview(title)
        contentView.addSubview(collectionView)
    }
    
    private func setLayout() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setViewModel(viewModel: ShoppingListViewModel) {
        self.viewModel = viewModel
        setBinding(viewModel: viewModel)
    }
}

extension ShoppingListBlock2: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.top5Items?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let item = viewModel.top5Items?[indexPath.row]
        else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingListCellForBlock2.id, for: indexPath) as! ShoppingListCellForBlock2
        cell.setViewModel(viewModel: viewModel)
        cell.setCell(imageURL: item.image, title: item.title, price: item.lprice)
        return cell
    }
}