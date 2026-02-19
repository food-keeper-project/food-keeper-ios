//
//  MockCategoryUseCase.swift
//  Domain
//
//  Created by 박성민 on 2/19/26.
//

import Foundation
import FoodKeeperFoundation
import RxSwift

public final class MockCategoryUseCase: CategoryUseCase {
    public init() { }
    
    public func fetchCategorys() -> Single<[FoodCategory]> {
        let mock = FoodCategory.mockList
        
        return Single.just(mock)
    }
}
