// Copyright © 2023 com.template. All rights reserved.

import UIKit

public class TabView: UITabBarController {
    
    private let firstView: UIViewController
    private let secondView: UIViewController
    
    public init(firstView: UIViewController, secondView: UIViewController) {
        self.firstView = firstView
        self.secondView = secondView
        super.init(nibName: nil, bundle: nil)
        setTab()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTab() {
        self.viewControllers = [firstView, secondView]
        firstView.tabBarItem = UITabBarItem(
            title: "물건검색",
            image: UIImage(systemName: "magnifyingglass.circle"),
            selectedImage: UIImage(systemName: "magnifyingglass.circle.fill")
        )
        secondView.tabBarItem = UITabBarItem(
            title: "장바구니", 
            image: UIImage(systemName: "bag"),
            selectedImage: UIImage(systemName: "bag.fill")
        )
    }
}
