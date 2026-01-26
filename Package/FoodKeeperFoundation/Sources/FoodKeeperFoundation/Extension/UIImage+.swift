//
//  UIImage+.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 1/26/26.
//

#if canImport(UIKit)
import UIKit

extension UIImage {
    public static let asAppIcon = UIImage(named: Secret.appIcon)
    public static let asAppLogo = UIImage(named: "AppLogo")
    
    public static let asCartPlus = UIImage(named: "CartPlus")
    public static let asChefHat = UIImage(named: "ChefHat")
    public static let asHome = UIImage(named: "Home")
    public static let asUserCircle = UIImage(named: "UserCircle")
    
}
#endif
