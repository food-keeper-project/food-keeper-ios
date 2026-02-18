//
//  FoodUseCase.swift
//  Domain
//
//  Created by 박성민 on 2/9/26.
//

import Foundation
import RxSwift

public protocol FoodUseCase {
    // 유통기한 마감 임박 식재료 조회
    func fetchExpiringFoods() -> Single<[FoodResponse]>
    
    // 사용자가 등록한 모든 식재료 조회
    func fetchAllFoods() -> Single<[FoodResponse]>
    
}
