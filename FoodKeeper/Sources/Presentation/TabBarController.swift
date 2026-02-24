//
//  TabBarController.swift
//  FoodKeeper
//
//  Created by 박성민 on 1/26/26.
//

import UIKit

import FoodKeeperFoundation


final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = TabKind.makeViewControllers()
    }
    
    enum TabKind: CaseIterable {
        case home
        case foodAdd
        case recipe
        case myPage
        
        static func makeViewControllers() -> [UIViewController] {
            return allCases.map { tabKind in
                let rootVC = tabKind.viewController
                rootVC.tabBarItem = tabKind.tabBarItem
                
                let navTitleView = NavTitleView(
                    image: .asColorAppLogo,
                    title: Design.StringLiteral.appName
                )
                navTitleView.isUserInteractionEnabled = false
                rootVC.navigationItem.title = ""
                rootVC.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navTitleView)
                if #available(iOS 26.0, *) {
                    rootVC.navigationItem.leftBarButtonItem?.hidesSharedBackground = true
                    rootVC.navigationItem.rightBarButtonItem?.hidesSharedBackground = true
                }
                let nav = UINavigationController(rootViewController: rootVC)
                return nav
            }
        }
        
        // MARK: - ViewController
        private var viewController: UIViewController {
            switch self {
            case .home:
                return HomeVC()
            case .foodAdd:
                return AddFoodVC()
            case .recipe:
                return RecipeVC()
            case .myPage:
                return MyPageVC()
            }
        }
        
        // MARK: - TabBarItem
        private var tabBarItem: UITabBarItem {
            UITabBarItem(
                title: title,
                image: image,
                selectedImage: selectedImage
            )
        }
        
        // MARK: - Title
        private var title: String {
            switch self {
            case .home:
                return Design.StringLiteral.tabBarHome
            case .foodAdd:
                return Design.StringLiteral.tabFoodAdd
            case .recipe:
                return Design.StringLiteral.tabBarRecipe
            case .myPage:
                return Design.StringLiteral.tabBarMyPage
            }
        }
        
        // MARK: - Images
        private var image: UIImage? {
            switch self {
            case .home:
                return .asHome
            case .foodAdd:
                return .asCartPlus
            case .recipe:
                return .asChefHat
            case .myPage:
                return .asUserCircle
            }
        }
        
        private var selectedImage: UIImage? {
            switch self {
            case .home:
                return .asHome
            case .foodAdd:
                return .asCartPlus
            case .recipe:
                return .asChefHat
            case .myPage:
                return .asUserCircle
            }
        }
    }
}
