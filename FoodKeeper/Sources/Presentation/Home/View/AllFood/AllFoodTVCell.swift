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
    private let containerView = UIView().then {
        $0.backgroundColor = .asBackground
    }
    private let foodImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 14
        $0.clipsToBounds = true
    }
    private let foodNameLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.font = .as16BodyBold
        $0.textColor = .black
    }
    private let foodDDayLabel = InsetLabel().then {
        $0.apply(style: .dDayBadge)
    }
    private let categoryLabel = UILabel().then {
        $0.font = .as12CaptionBold
        $0.textColor = .asGray1
        $0.numberOfLines = 1
        $0.textAlignment = .left
    }
    private let expiringLabel = UILabel().then {
        $0.font = .as12CaptionBold
        $0.textColor = .asBlack
        $0.numberOfLines = 1
        $0.textAlignment = .left
    }
    private let expiredBedge = InsetLabel().then {
        $0.apply(style: .epiringBadge)
        $0.text = "유통기한 임박!"
        $0.isHidden = true
    }
    
    override func setUpLayout() {
        contentView.addSubview(containerView)
        [foodImageView, foodNameLabel, foodDDayLabel, categoryLabel, expiringLabel, expiredBedge].forEach { containerView.addSubview($0) }
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(7)
            make.horizontalEdges.equalToSuperview()
        }
        foodImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(foodImageView.snp.height)
        }
        foodNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalTo(foodImageView.snp.trailing).offset(20)
        }
        foodDDayLabel.snp.makeConstraints { make in
            make.leading.equalTo(foodNameLabel.snp.trailing).offset(6)
            make.centerY.equalTo(foodNameLabel)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(foodNameLabel.snp.bottom).offset(15)
            make.leading.equalTo(foodNameLabel.snp.leading)
        }
        expiringLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel)
            make.leading.equalTo(categoryLabel.snp.trailing).offset(4)
        }
        expiredBedge.snp.makeConstraints { make in
            make.leading.equalTo(expiringLabel.snp.trailing).offset(6)
            make.centerY.equalTo(expiringLabel)
        }
    }
    override func setUpUI() {
        contentView.backgroundColor = .asBackground
    }
    func setUpData(data: FoodResponse) {
        foodImageView.setFoodImage(urlString: data.imageURL)
        
        foodNameLabel.text = data.name
        foodDDayLabel.text = data.expiryDate.dDayString()
        
        categoryLabel.text = data.categorys.first?.name ?? "알수없음"
        expiringLabel.text = "유통기한 " + data.expiryDate.toyyMMddString()
        
        expiredBedge.isHidden = !(data.expiryDate.dDayInt() <= 7)
    
        
    }
}
