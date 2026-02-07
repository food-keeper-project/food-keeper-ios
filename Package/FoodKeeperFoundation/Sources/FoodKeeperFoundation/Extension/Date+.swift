//
//  File.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 2/7/26.
//

import Foundation


public extension Date {
    /// Date → "yy.MM.dd"
    func toyyMMddString() -> String {
        DateFormatterCache.yyMMdd.string(from: self)
    }
    
    /// Date → "yy.MM.dd (요일)"
    func toyyMMddWithDay() -> String {
        DateFormatterCache.yyMMddWithDay.string(from: self)
    }
    
    /// 오늘 기준 D-Day Int 반환
    /// - 미래: -N
    /// - 과거: +N
    /// - 오늘: 0
    func dDayInt(from today: Date = Date()) -> Int {
        let calendar = Calendar.current
        let startSelf = calendar.startOfDay(for: self)
        let startToday = calendar.startOfDay(for: today)

        let diff = startToday.timeIntervalSince(startSelf)
        return Int(diff / 86400)
    }

    /// 오늘 기준 D-Day 문자열 반환
    /// - 예: D-3, D+5, D-Day
    func dDayString(from today: Date = Date()) -> String {
        let dDay = dDayInt(from: today)

        if dDay == 0 {
            return "D-Day"
        } else if dDay > 0 {
            return "D+\(dDay)"
        } else {
            return "D\(dDay)"   // dDay 자체가 음수 → D-3 형태
        }
    }
}
