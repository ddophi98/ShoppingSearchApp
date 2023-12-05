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
    
    public override func viewDidLoad() {
        setView()
        setLayout()
        setBinding()
    }
    
    private func setBinding() {

    }
    
    private func setView() {
        view.backgroundColor = .white

    }
    
    private func setLayout() {

    }
}
