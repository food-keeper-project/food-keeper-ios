//
//  Injected.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 2/18/26.
//

import Foundation

@propertyWrapper
public struct Injected<T> {
    public var wrappedValue: T {
        DIContainer.resolve(type: T.self)
    }
    
    public init() { }
}
