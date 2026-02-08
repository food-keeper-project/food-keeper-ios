//
//  AllFoodSection.swift
//  FoodKeeper
//
//  Created by 박성민 on 2/8/26.
//

import Foundation

import RxDataSources
import Domain

struct AllFoodSection {
    var header: String
    var items: [FoodResponse]
}

extension AllFoodSection: SectionModelType {
    typealias Item = FoodResponse

    init(original: AllFoodSection, items: [FoodResponse]) {
        self = original
        self.items = items
    }
}
