//
//  ExpiringInfoView.swift
//  FoodKeeper
//
//  Created by 박성민 on 2/7/26.
//

import UIKit
import FoodKeeperFoundation

import SnapKit
import Then

final class ExpiringInfoView: BaseView {
    private let expiringInfo1 = UILabel().then {
        $0.text = "유통기한 임박 식품"
        $0.font = .as22TitleBold
        $0.textColor = .asWhite
        $0.numberOfLines = 2
    }
    private let expiringInfo2 = UILabel().then {
        $0.text = "현재"
        $0.font = .as22TitleBold
        $0.textColor = .asWhite
        $0.numberOfLines = 2
    }
    private let expiringInfo3 = UILabel().then {
        $0.text = "보유중 입니다"
        $0.font = .as22TitleBold
        $0.textColor = .asWhite
        $0.numberOfLines = 2
    }
    let expiringCount = PaddingLabel().then {
        $0.text = "0개"
        $0.padding = .init(top: 4, left: 8, bottom: 4, right: 8)
        $0.backgroundColor = .asWhite
        $0.font = .as22TitleBold
        $0.textColor = .asMainOrange
        $0.numberOfLines = 2
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 6
    }
    
    
    override func setUpLayout() {
        [expiringInfo1, expiringInfo2, expiringInfo3, expiringCount,].forEach {self.addSubview($0)}
        expiringInfo1.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        expiringInfo2.snp.makeConstraints { make in
            make.centerY.equalTo(expiringCount)
            make.leading.equalToSuperview()
        }
        expiringCount.snp.makeConstraints { make in
            make.top.equalTo(expiringInfo1.snp.bottom).offset(7)
            make.leading.equalTo(expiringInfo2.snp.trailing).offset(6)
        }
        expiringInfo3.snp.makeConstraints { make in
            make.centerY.equalTo(expiringCount)
            make.leading.equalTo(expiringCount.snp.trailing).offset(6)
        }
    }
    override func setUpUI() {
        
    }
}
