//
//  CategoryUseCase.swift
//  Domain
//
//  Created by 박성민 on 2/9/26.
//

import Foundation
import RxSwift

public protocol CategoryUseCase {
    //카테고리 리스트 조회
    func fetchCategorys() -> Single<[FoodCategory]>
    
}

