//
//  FoodResponse.swift
//  Domain
//
//  Created by 박성민 on 2/3/26.
//

import Foundation

public struct FoodResponse: Hashable {
    public let id: Int64 // 고유 ID
    public let name: String //식재료명
    public let imageURL: String //이미지 URL 경로
    public var imageData: Data? //이미지 데이터
    public let storageMethod: StorageMethod //보관방법
    public let expiryDate: Date // 유통기한 만료일
    public let memo: String // 메모
    public let createdAt: Date // 생성일
    public let categorys: [FoodCategory] //카테고리
    public let expiryAlarm: Int //알림일
}

// 목업
public extension FoodResponse {

    @MainActor static let mockList: [FoodResponse] = [
        FoodResponse(
            id: 1,
            name: "파프리카",
            imageURL: "https://picsum.photos/seed/paprika/200/200",
            imageData: nil,
            storageMethod: .refrigerated,
            expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 4),
            memo: "샐러드용",
            createdAt: Date().addingTimeInterval(60 * 60 * 24 * 4),
            categorys: [FoodCategory(id: 1, name: "채소")],
            expiryAlarm: 3
        ),
        FoodResponse(
            id: 2,
            name: "건조 야채 믹스",
            imageURL: "https://picsum.photos/seed/dryveg/200/200",
            imageData: nil,
            storageMethod: .roomTemp,
            expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 5),
            memo: "캠핑용",
            createdAt: Date(),
            categorys: [
                FoodCategory(id: 1, name: "채소"),
                FoodCategory(id: 5, name: "간편식")
            ],
            expiryAlarm: 5
        ),
        FoodResponse(
            id: 3,
            name: "스테이크용 소고기",
            imageURL: "https://picsum.photos/seed/beef/200/200",
            imageData: nil,
            storageMethod: .freezer,
            expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 6),
            memo: "안심",
            createdAt: Date().addingTimeInterval(60 * 60 * 24 * 6),
            categorys: [FoodCategory(id: 2, name: "육류")],
            expiryAlarm: 2
        ),
        FoodResponse(
            id: 4,
            name: "양배추",
            imageURL: "https://picsum.photos/seed/cabbage/200/200",
            imageData: nil,
            storageMethod: .refrigerated,
            expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 7),
            memo: "",
            createdAt: Date(),
            categorys: [FoodCategory(id: 1, name: "채소")],
            expiryAlarm: 3
        ),
        FoodResponse(
            id: 5,
            name: "블루베리",
            imageURL: "https://picsum.photos/seed/blueberry/200/200",
            imageData: nil,
            storageMethod: .refrigerated,
            expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 3),
            memo: "요거트 토핑",
            createdAt: Date().addingTimeInterval(60 * 60 * 24 * 3),
            categorys: [FoodCategory(id: 3, name: "과일")],
            expiryAlarm: 1
        ),
        FoodResponse(
            id: 6,
            name: "우유",
            imageURL: "https://picsum.photos/seed/milk/200/200",
            imageData: nil,
            storageMethod: .refrigerated,
            expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 2),
            memo: "저지방",
            createdAt: Date(),
            categorys: [FoodCategory(id: 4, name: "유제품")],
            expiryAlarm: 1
        ),
        FoodResponse(
            id: 7,
            name: "치즈",
            imageURL: "https://picsum.photos/seed/cheese/200/200",
            imageData: nil,
            storageMethod: .refrigerated,
            expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 10),
            memo: "파스타용",
            createdAt: Date(),
            categorys: [FoodCategory(id: 4, name: "유제품")],
            expiryAlarm: 4
        ),
        FoodResponse(
            id: 8,
            name: "닭가슴살",
            imageURL: "https://picsum.photos/seed/chicken/200/200",
            imageData: nil,
            storageMethod: .freezer,
            expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 14),
            memo: "운동 후",
            createdAt: Date(),
            categorys: [FoodCategory(id: 2, name: "육류")],
            expiryAlarm: 5
        ),
        FoodResponse(
            id: 9,
            name: "즉석밥",
            imageURL: "https://picsum.photos/seed/rice/200/200",
            imageData: nil,
            storageMethod: .roomTemp,
            expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 30),
            memo: "비상식량",
            createdAt: Date(),
            categorys: [FoodCategory(id: 5, name: "간편식")],
            expiryAlarm: 7
        ),
        FoodResponse(
            id: 10,
            name: "사과",
            imageURL: "https://picsum.photos/seed/apple/200/200",
            imageData: nil,
            storageMethod: .refrigerated,
            expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 8),
            memo: "아침용",
            createdAt: Date(),
            categorys: [FoodCategory(id: 3, name: "과일")],
            expiryAlarm: 3
        )
    ]
}
