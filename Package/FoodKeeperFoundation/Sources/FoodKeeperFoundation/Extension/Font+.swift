//
//  File.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 1/21/26.
//

#if canImport(UIKit)
import UIKit

extension UIFont {
    public static let asHeading = UIFont.asFont(.nanumSquareNeoRegular, 36)
    
    public static let asTitle26 = UIFont.asFont(.nanumSquareNeoRegular, 26)
    public static let asTitle22 = UIFont.asFont(.nanumSquareNeoRegular, 22)
    public static let asTitle19 = UIFont.asFont(.nanumSquareNeoRegular, 19)

    public static let asTitle26Bold = UIFont.asFont(.nanumSquareNeoBold, 26)
    public static let asTitle22Bold = UIFont.asFont(.nanumSquareNeoBold, 22)
    public static let asTitle19Bold = UIFont.asFont(.nanumSquareNeoBold, 19)

    public static let asBody16 = UIFont.asFont(.nanumSquareNeoRegular, 16)
    public static let asBody14 = UIFont.asFont(.nanumSquareNeoRegular, 14)
    
    public static let asBody16Bold = UIFont.asFont(.nanumSquareNeoBold, 16)
    public static let asBody14Bold = UIFont.asFont(.nanumSquareNeoBold, 14)

    public static let asCaption12 = UIFont.asFont(.nanumSquareNeoRegular, 12)
    public static let asCaption10 = UIFont.asFont(.nanumSquareNeoRegular, 10)

    public static let asCaption12Bold = UIFont.asFont(.nanumSquareNeoBold, 12)
    public static let asCaption10Bold = UIFont.asFont(.nanumSquareNeoBold, 10)
}

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
