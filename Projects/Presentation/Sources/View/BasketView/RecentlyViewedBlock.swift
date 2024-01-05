// Copyright © 2023 com.template. All rights reserved.

import Domain
import RxSwift
import SnapKit
import UIKit

final public class RecentlyViewedBlock: UITableViewCell {
    static let id = "RecentlyViewedBlock"
    private var viewModel: BasketViewModel?
    private var items: [RecentlyViewedVO]?
    private var disposeBag = DisposeBag()
    
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
        title.text = "최근 본 상품"
        title.font = .systemFont(ofSize: 20)
        return title
    }()
    lazy private var collectionView: UICollectionView = {
        let collectionViewFlowLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 20.0
            layout.itemSize = .init(width: 100, height: 150)
            layout.sectionInset = .init(top: 0, left: 30, bottom: 0, right: 30)
            return layout
        }()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(RecentlyViewedCell.self, forCellWithReuseIdentifier: RecentlyViewedCell.id)
        return collectionView
    }()
    
    private func setBinding() {
        guard let  viewModel = viewModel else { return }
        viewModel.contentsAreChanged
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
                guard let self = self else { return }
                collectionView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    private func setView() {
        selectionStyle = .none
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
    
    func setItems(viewModel: BasketViewModel, items: [RecentlyViewedVO]) {
        self.viewModel = viewModel
        self.items = items
        setBinding()
    }
    
    public override func prepareForReuse() {
        // 재사용하게 되면 다른 셀이 구독했던게 남아있으므로 명시적으로 구독 해제해주기
        disposeBag = DisposeBag()
    }
}

extension RecentlyViewedBlock: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let item = items?[indexPath.row]
        else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyViewedCell.id, for: indexPath) as! RecentlyViewedCell
        cell.setCell(viewModel: viewModel, imageURL: item.image, title: item.title, price: item.price)
        return cell
    }
}

