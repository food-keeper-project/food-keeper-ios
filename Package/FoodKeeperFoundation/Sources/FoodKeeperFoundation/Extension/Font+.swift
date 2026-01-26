//
//  File.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 1/21/26.
//

#if canImport(UIKit)
import UIKit

enum CustomFontName: String {
    case nanumSquareNeoLight   = "NanumSquareNeo-aLt"
    case nanumSquareNeoRegular = "NanumSquareNeo-bRg"
    case nanumSquareNeoBold    = "NanumSquareNeo-cBd"
    case nanumSquareNeoExtraBold = "NanumSquareNeo-dEb"
    case nanumSquareNeoHeavy   = "NanumSquareNeo-eHv"
}

extension UIFont {
    static func asFont(_ font: CustomFontName, _ size: CGFloat) -> UIFont {
        return UIFont(name: font.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
#endif
