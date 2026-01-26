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
    
    public enum StringLiteral {
        public static let appName = "키친로그"
        
        public static let tabBarHome = "홈"
        public static let tabFoodAdd = "식재료 추가"
        public static let tabBarRecipe = "레시피 목록"
        public static let tabBarMyPage = "마이페이지"
    }
    
}
#endif
