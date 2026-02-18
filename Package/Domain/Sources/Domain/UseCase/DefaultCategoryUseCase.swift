//
//  DefaultCategoryUseCase.swift
//  Domain
//
//  Created by 박성민 on 2/9/26.
//

import Foundation
import FoodKeeperFoundation
import RxSwift

public final class DefaultCategoryUseCase: CategoryUseCase {
    public init() { }
    
    public func fetchCategorys() -> Single<[FoodCategory]> {
        let mock = FoodCategory.mockList
        
        return Single.just(mock)
    }
}
