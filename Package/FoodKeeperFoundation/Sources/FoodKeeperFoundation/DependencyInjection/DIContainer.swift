//
//  DIContainer.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 2/18/26.
//

import Foundation

public enum DIContainer {
    nonisolated(unsafe) static var storage = [String: Any]()
    
    public static func register<T>(_ value: T, type: T.Type) {
        storage["\(type)"] = value
    }
    
    public static func resolve<T>(type: T.Type) -> T {
        guard let object = storage["\(type)"] as? T else {
            fatalError("등록되지 않은 객체 호출: \(type)")
        }
        return object
    }
}
