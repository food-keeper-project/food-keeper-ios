//
//  Appearance.swift
//  FoodKeeper
//
//  Created by 박성민 on 1/26/26.
//

import UIKit

import FoodKeeperFoundation
import Then

enum Appearance {
    static func setUpCommonUI() {
        setUpNavigationBarUI()
        setUpTabBarUI()
    }
    
    private static func setUpNavigationBarUI() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .asBackground
        appearance.shadowColor = UIColor.clear

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .asForeground
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont.asHeading,
            .foregroundColor: UIColor.asForeground
        ]
    }
    private static func setUpTabBarUI() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .asForeground
        appearance.shadowColor = UIColor.clear

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().tintColor = UIColor.asForeground
    }
}
