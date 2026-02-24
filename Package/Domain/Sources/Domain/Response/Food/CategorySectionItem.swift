//
//  CategorySectionItem.swift
//  Domain
//
//  Created by 박성민 on 2/24/26.
//

import Foundation

public struct CategorySectionItem {
    
    public let category: FoodCategory
    public let isSelected: Bool
    public init(category: FoodCategory, isSelected: Bool) {
        self.category = category
        self.isSelected = isSelected
    }
}
