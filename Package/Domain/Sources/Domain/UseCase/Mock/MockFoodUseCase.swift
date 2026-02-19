//
//  MockFoodUseCase.swift
//  Domain
//
//  Created by 박성민 on 2/19/26.
//

import Foundation
import FoodKeeperFoundation
import RxSwift

public final class MockFoodUseCase: FoodUseCase {
    public init() { }
    
    public func fetchExpiringFoods() -> Single<[FoodResponse]> {
        let mock = FoodResponse.mockList
        
        return Single.just(mock)
    }
    public func fetchAllFoods() -> Single<[FoodResponse]> {
        let mock = FoodResponse.mockList
        
        return Single.just(mock)
    }
}
