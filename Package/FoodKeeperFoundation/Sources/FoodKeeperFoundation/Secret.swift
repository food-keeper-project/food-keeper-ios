//
//  File.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 1/21/26.
//

import Foundation

public enum Secret {
    public static let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    
    public static let appIcon = Bundle.main.object(forInfoDictionaryKey: "APP_ICON") as? String ?? ""
    public static let appName = Bundle.main.object(forInfoDictionaryKey: "APP_NAME") as? String ?? ""
}
