//
//  AppDelegate+Register.swift
//  FoodKeeper
//
//  Created by 박성민 on 2/18/26.
//

import Foundation
import FoodKeeperFoundation
import Domain
import Data

extension AppDelegate {
    func registerDependency() {

        #if FAKE
        print("FAKE")
        // MARK: - UseCase
        DIContainer.register(MockFoodUseCase(), type: FoodUseCase.self)
        DIContainer.register(MockCategoryUseCase(), type: CategoryUseCase.self)
        
        #else
        print("DEBUG")
        // MARK: - UseCase
        DIContainer.register(DefaultFoodUseCase(), type: FoodUseCase.self)
        DIContainer.register(DefaultCategoryUseCase(), type: CategoryUseCase.self)
        #endif
        
    }
}

