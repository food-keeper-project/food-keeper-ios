//
//  Coordinator.swift
//  FoodKeeper
//
//  Created by 박성민 on 1/31/26.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}


//final class AppCoordinator: Coordinator {
//
//    var childCoordinators: [Coordinator] = []
//    private let router: RouterProtocol
//
//    init(window: UIWindow) {
//        let navigationController = UINavigationController()
//        self.router = Router(navigationController: navigationController)
//
//        window.rootViewController = navigationController
//        window.makeKeyAndVisible()
//    }
//
//    func start() {
//        let homeCoordinator = HomeCoordinator(router: router)
//        childCoordinators.append(homeCoordinator)
//        homeCoordinator.start()
//    }
//}
