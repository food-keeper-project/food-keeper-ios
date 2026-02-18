//
//  DIContainer.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 2/18/26.
//

import Foundation

public final class DIContainer: @unchecked Sendable {
    
    public static let shared = DIContainer()
    
    private var storage: [ObjectIdentifier: Any] = [:]
    private let lock = NSRecursiveLock()
    
    private init() {}
    
    // MARK: - Register
    
    public func registerSingleton<T>(
        _ type: T.Type,
        instance: T
    ) {
        let key = ObjectIdentifier(type)
        lock.lock()
        storage[key] = instance
        lock.unlock()
    }
    
    public func registerFactory<T>(
        _ type: T.Type,
        factory: @escaping () -> T
    ) {
        let key = ObjectIdentifier(type)
        lock.lock()
        storage[key] = factory
        lock.unlock()
    }
    
    // MARK: - Resolve
    
    public func resolve<T>(_ type: T.Type) -> T {
        let key = ObjectIdentifier(type)
        
        lock.lock()
        defer { lock.unlock() }
        
        guard let entry = storage[key] else {
            fatalError("등록되지 않은 타입: \(type)")
        }
        
        // Singleton
        if let instance = entry as? T {
            return instance
        }
        
        // Factory
        if let factory = entry as? () -> T {
            return factory()
        }
        
        fatalError("타입 캐스팅 실패: \(type)")
    }
}
