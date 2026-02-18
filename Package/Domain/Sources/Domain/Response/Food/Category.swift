//
//  Category.swift
//  Domain
//
//  Created by 박성민 on 2/3/26.
//

import Foundation

public struct FoodCategory: Hashable {
    public let id: Int64
    public let name: String
    
    public init(id: Int64, name: String) {
        self.id = id
        self.name = name
    }
}

// 목업
public extension FoodCategory {
    nonisolated(unsafe) static let mockList: [FoodCategory] = [
        FoodCategory(id: 1, name: "야채류"),
        FoodCategory(id: 2, name: "과일류"),
        FoodCategory(id: 3, name: "육류"),
        FoodCategory(id: 4, name: "해산물"),
        FoodCategory(id: 5, name: "유제품"),
        FoodCategory(id: 6, name: "냉동식품"),
        FoodCategory(id: 7, name: "가공식품"),
        FoodCategory(id: 8, name: "즉석식품"),
        FoodCategory(id: 9, name: "곡류"),
        FoodCategory(id: 10, name: "조미료")
    ]
}
