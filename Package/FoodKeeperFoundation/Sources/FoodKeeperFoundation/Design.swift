//
//  Design.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 1/26/26.
//

#if canImport(UIKit)
import UIKit

public enum Design {
    public enum Dimension {
        public static let symbolSize_40: CGFloat = 40
        public static let tableViewFooter_20: CGFloat = 20
        public static let progressViewHeight_15: CGFloat = 15
    }
    
    public enum Padding {
        public static let regular_22: CGFloat = 22
        public static let medium_16: CGFloat = 16
        public static let small_10: CGFloat = 10
        public static let extraSmall_5: CGFloat = 5
    }
    
    public enum Radius {
        public static let regular_8: CGFloat = 8
        public static let medium_20: CGFloat = 20
        public static let large_25: CGFloat = 25
    }
    
    public enum Color {
        public static let background = UIColor(hex: "FBFBFB")
        public static let mainOrange = UIColor(hex: "FF7F1E")
        public static let accentYellow = UIColor(hex: "FECE00")
        
        public static let asBlack = UIColor(hex: "2F2F2F")
        public static let asGray1 = UIColor(hex: "A2A2A2")
        public static let asGray2 = UIColor(hex: "BBBBBB")
        public static let asGray3 = UIColor(hex: "D7D7D7")
        public static let asGray4 = UIColor(hex: "DEDEDE")
        public static let asGray5 = UIColor(hex: "F5F5F5")
    }
    
    public enum Font {
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
    
    public enum StringLiteral {
        public static let appName = "키친로그"
        
        public static let tabBarHome = "홈"
        public static let tabFoodAdd = "식재료 추가"
        public static let tabBarRecipe = "레시피 목록"
        public static let tabBarMyPage = "마이페이지"
    }
    
    public enum ImageLiteral {
        public static let appIcon = UIImage(named: "appLogo_Color")
        public static let appLogo = UIImage(named: "appLogo")
        
        public static let cartPlus = UIImage(named: "CartPlus")
        public static let chefHat = UIImage(named: "ChefHat")
        public static let home = UIImage(named: "Home")
        public static let userCircle = UIImage(named: "UserCircle")
        
    }
}
#endif
