// Copyright © 2023 com.template. All rights reserved.

import UIKit
import SnapKit
import Domain
import RxSwift

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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loggingTTI(point: .loadView)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loggingViewAppeared()
        viewModel.loggingTTI(point: .drawView)
    }
    
    lazy private var viewTitle: UILabel = {
        let viewTitle = UILabel()
        viewTitle.text = "상품검색"
        viewTitle.font = .boldSystemFont(ofSize: 30)
        return viewTitle
    }()
    
    private lazy var searchBox: UITextField = {
        let searchBox = UITextField()
        searchBox.placeholder = "찾고 싶은 상품을 입력해주세요"
        searchBox.font = .systemFont(ofSize: 15)
        searchBox.borderStyle = .roundedRect
        searchBox.clearButtonMode = .whileEditing
        searchBox.delegate = self
        return searchBox
    }()
    
    private lazy var topLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray4
        return line
    }()
    
    private lazy var bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray4
        return line
    }()
    
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
            group.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 60, leading: 0, bottom: 30, trailing: 0)
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
            ]
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
                heightDimension: .absolute(200)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.contentInsets = .init(top: 60, leading: 0, bottom: 30, trailing: 0)
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
            ]
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
        collectionView.register(ShoppingListHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ShoppingListHeader.id)
        return collectionView
    }()
    
    private lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.font = .boldSystemFont(ofSize: 40)
        errorLabel.textColor = .white
        errorLabel.backgroundColor = .init(white: 0.0, alpha: 0.5)
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
        return errorLabel
    }()
    
    private func setBinding() {        
        viewModel.sectionsChangedRelay
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
                guard let self = self else { return }
                collectionView.reloadData()
                viewModel.loggingTTI(point: .bindData)
            }
            .disposed(by: viewModel.disposeBag)
        
        
        viewModel.errorRelay
            .observe(on: MainScheduler.instance)
            .bind { [weak self] errorString in
                guard let self = self else { return }
                errorLabel.text = errorString
                errorLabel.isHidden = false
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    private func setView() {
        view.backgroundColor = .white
        view.addSubview(viewTitle)
        view.addSubview(searchBox)
        view.addSubview(collectionView)
        view.addSubview(topLine)
        view.addSubview(bottomLine)
        view.addSubview(errorLabel)
    }
    
    private func setLayout() {
        viewTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        searchBox.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(searchBox.snp.bottom).offset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        topLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.top)
            make.height.equalTo(0.5)
        }
        bottomLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom)
            make.height.equalTo(0.5)
        }
        errorLabel.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    public func setCoordinator(_ coordinator: Coordinator) {
        viewModel.coordinator = coordinator
    }
}

extension ShoppingListView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        guard let query = textField.text else { return true }
        viewModel.searchShopping(query: query)
        viewModel.loggingTTI(point: .sendRequest)
        return true
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
            viewModel.moveToDetailView(item: items[indexPath.item], position: "모든상품", index: indexPath.item)
        case .TopFiveProducts(let items):
            viewModel.moveToDetailView(item: items[indexPath.item], position: "상위5개상품", index: indexPath.item)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ShoppingListHeader.id, for: indexPath) as! ShoppingListHeader
        
        switch viewModel.sections[indexPath.section] {
        case .AllProducts:
            header.setHeader("모든 상품")
        case .TopFiveProducts:
            header.setHeader("상위 5개 상품")
        }
        
        return header
    }
}
