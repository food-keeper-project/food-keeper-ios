//
//  File.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 2/7/26.
//

import Foundation

internal enum DateFormatterCache {
    
    static let yyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        formatter.locale = Locale.current
        return formatter
    }()
    
    static let yyMMddWithDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd (E)"
        formatter.locale = Locale.current
        return formatter
    }()
    
    static let serverDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale.current
        return formatter
    }()
    
    static let serverDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.locale = Locale.current
        return formatter
    }()
    
    static let isoUTC: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.locale = Locale.current
        return formatter
    }()
}
