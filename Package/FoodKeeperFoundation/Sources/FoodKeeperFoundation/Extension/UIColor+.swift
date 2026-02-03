//
//  File.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 1/21/26.
//

#if canImport(UIKit)
import UIKit
extension UIColor {
    public static let asForeground = UIColor(hex: "2F2F2F")
    public static let asBackground = UIColor(hex: "FBFBFB")
    public static let asMainOrange = UIColor(hex: "FF7F1E")
    public static let asAccentYellow = UIColor(hex: "FECE00")
    
    public static let asWhite = UIColor(hex: "FBFBFB")
    public static let asBlack = UIColor(hex: "2F2F2F")
    public static let asGray1 = UIColor(hex: "A2A2A2")
    public static let asGray2 = UIColor(hex: "BBBBBB")
    public static let asGray3 = UIColor(hex: "D7D7D7")
    public static let asGray4 = UIColor(hex: "DEDEDE")
    public static let asGray5 = UIColor(hex: "F5F5F5")
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
#endif
