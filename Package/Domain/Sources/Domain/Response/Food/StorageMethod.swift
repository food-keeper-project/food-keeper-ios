//
//  StorageMethod.swift
//  Domain
//
//  Created by 박성민 on 2/3/26.
//

import Foundation

public enum StorageMethod: String, CaseIterable {
    case roomTemp = "실온"
    case refrigerated = "냉장"
    case freezer = "냉동"
    
    public var displayName: String {
        return self.rawValue
    }
}
