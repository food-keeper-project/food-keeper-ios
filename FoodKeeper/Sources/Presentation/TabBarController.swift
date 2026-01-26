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

                let nav = UINavigationController(rootViewController: rootVC)
                return nav
            }
        }

        // MARK: - ViewController
        private var viewController: UIViewController {
            let vc = UIViewController()
            vc.view.backgroundColor = Design.Color.background
            vc.title = title
            switch self {
            case .home:
                return vc
            case .foodAdd:
                return vc
            case .recipe:
                return vc
            case .myPage:
                return vc
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
                return Design.ImageLiteral.home
            case .foodAdd:
                return Design.ImageLiteral.cartPlus
            case .recipe:
                return Design.ImageLiteral.chefHat
            case .myPage:
                return Design.ImageLiteral.userCircle
            }
        }

        private var selectedImage: UIImage? {
            switch self {
            case .home:
                return Design.ImageLiteral.home
            case .foodAdd:
                return Design.ImageLiteral.cartPlus
            case .recipe:
                return Design.ImageLiteral.chefHat
            case .myPage:
                return Design.ImageLiteral.userCircle
            }
        }
    }
}
