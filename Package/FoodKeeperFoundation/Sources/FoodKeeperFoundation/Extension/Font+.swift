//
//  File.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 1/21/26.
//

#if canImport(UIKit)
import UIKit
import CoreText

extension UIFont {

    public static let as36Heading = UIFont.asFont(.nanumSquareNeoRegular, 36)
    public static let as19ExtraLargeTitle = UIFont.asFont(.nanumSquareNeoExtraBold, 19)

    public static let as26Title = UIFont.asFont(.nanumSquareNeoRegular, 26)
    public static let as22Title = UIFont.asFont(.nanumSquareNeoRegular, 22)
    public static let as19Title = UIFont.asFont(.nanumSquareNeoRegular, 19)
    public static let as26TitleBold = UIFont.asFont(.nanumSquareNeoBold, 26)
    public static let as22TitleBold = UIFont.asFont(.nanumSquareNeoBold, 22)
    public static let as19TitleBold = UIFont.asFont(.nanumSquareNeoBold, 19)
    
    public static let as16Body = UIFont.asFont(.nanumSquareNeoRegular, 16)
    public static let as14Body = UIFont.asFont(.nanumSquareNeoRegular, 14)
    public static let as16BodyBold = UIFont.asFont(.nanumSquareNeoBold, 16)
    public static let as14BodyBold = UIFont.asFont(.nanumSquareNeoBold, 14)
    
    public static let as12Caption = UIFont.asFont(.nanumSquareNeoRegular, 12)
    public static let as10Caption = UIFont.asFont(.nanumSquareNeoRegular, 10)
    public static let as12CaptionBold = UIFont.asFont(.nanumSquareNeoBold, 12)
    public static let as10CaptionBold = UIFont.asFont(.nanumSquareNeoBold, 10)
}

enum CustomFontName: String {
    case nanumSquareNeoLight      = "NanumSquareNeoTTF-aLt"
    case nanumSquareNeoRegular   = "NanumSquareNeoTTF-bRg"
    case nanumSquareNeoBold      = "NanumSquareNeoTTF-cBd"
    case nanumSquareNeoExtraBold = "NanumSquareNeoTTF-dEb"
    case nanumSquareNeoHeavy     = "NanumSquareNeoTTF-eHv"
}

extension UIFont {
    static func asFont(_ font: CustomFontName, _ size: CGFloat) -> UIFont {
        return UIFont(name: font.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    //커스텀 폰트 등록
    public static func registerFonts() {
        let fontNames = [
            "NanumSquareNeo-aLt",
            "NanumSquareNeo-bRg",
            "NanumSquareNeo-cBd",
            "NanumSquareNeo-dEb",
            "NanumSquareNeo-eHv"
        ]

        fontNames.forEach { name in
            guard
                let url = Bundle.module.url(forResource: name, withExtension: "ttf"),
                let data = try? Data(contentsOf: url),
                let provider = CGDataProvider(data: data as CFData),
                let font = CGFont(provider)
            else {
                assertionFailure("❌ Font not found: \(name)")
                return
            }

            CTFontManagerRegisterGraphicsFont(font, nil)
        }
    }
}

#endif
