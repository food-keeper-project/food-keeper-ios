//
//  AllFoodTVCell.swift
//  FoodKeeper
//
//  Created by 박성민 on 2/8/26.
//

import UIKit
import FoodKeeperFoundation
import Domain

import SnapKit
import Then
import RxCocoa
import RxSwift

final class AllFoodTVCell: BaseTVCell {
    private let foodImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    private let foodNameLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.font = .as16BodyBold
        $0.textColor = .black
    }
    override func setUpLayout() {
        
    }
    override func setUpUI() {
        
    }
}
