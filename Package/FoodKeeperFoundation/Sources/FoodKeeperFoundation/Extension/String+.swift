//
//  File.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 2/7/26.
//

import Foundation

public extension String {

    func parseServerDate() -> Date {

        if let date = DateFormatterCache.serverDate.date(from: self) {
            return date
        }

        if let date = DateFormatterCache.serverDateTime.date(from: self) {
            return date
        }

        return Date()
    }
}
