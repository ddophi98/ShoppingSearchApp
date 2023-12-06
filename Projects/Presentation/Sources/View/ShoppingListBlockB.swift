// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit

public class ShoppingListBlockB: UITableViewCell {
    
    static let id = "ShoppingListBlockB"
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
            layout.itemSize = .init(width: ShoppingListCellB.cellWidth, height: ShoppingListCellB.cellHeight)
            return layout
        }()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ShoppingListCellB.self, forCellWithReuseIdentifier: ShoppingListCellB.id)
        return collectionView
    }()
    
    private func setBinding(viewModel: ShoppingListViewModel) {
        viewModel.$shoppingResultVO
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shoppingResultVO in
                self?.collectionView.reloadData()
            }
            .store(in: &viewModel.cancellable)
    }
    
    private func setView() {
        addSubview(title)
        contentView.addSubview(collectionView)
    }
    
    private func setLayout() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setViewModel(viewModel: ShoppingListViewModel) {
        self.viewModel = viewModel
        setBinding(viewModel: viewModel)
    }
}

extension ShoppingListBlockB: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.shoppingResultVO?.items.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = viewModel?.shoppingResultVO?.items[indexPath.row],
              let viewModel = viewModel
        else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingListCellB.id, for: indexPath) as! ShoppingListCellB
        cell.setViewModel(viewModel: viewModel)
        cell.setCell(imageURL: item.image, title: item.title, price: item.lprice)
        return cell
    }
}
