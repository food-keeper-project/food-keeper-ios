//
//  FoodResponse.swift
//  Domain
//
//  Created by 박성민 on 2/3/26.
//

import Foundation

public struct FoodResponse {
    public let id: Int64 // 고유 ID
    public let name: String //식재료명
    public let imageURL: String //이미지 URL 경로
    public var imageData: Data? //이미지 데이터
    public let storageMethod: StorageMethod //보관방법
    public let expiryDate: Date // 유통기한 만료일
    public let memo: String // 메모
    public let createdAt: Date // 생성일
    public let categorys: [Category] //카테고리
    public let expiryAlarm: Int //알림일
}
