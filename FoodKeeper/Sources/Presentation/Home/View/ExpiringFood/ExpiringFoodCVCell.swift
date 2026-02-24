//
//  ExpiringFoodCVCell.swift
//  FoodKeeper
//
//  Created by 박성민 on 2/3/26.
//

import UIKit
import FoodKeeperFoundation
import Domain

import SnapKit
import Then
import RxCocoa
import RxSwift


final class ExpiringFoodCVCell: BaseCVCell {
    private var disposeBag = DisposeBag()
    
    private let foodImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .asWhite
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
    }
    private let nameLabel = UILabel().then {
        $0.font = .as16BodyBold
        $0.textColor = .asBlack
        $0.numberOfLines = 1
    }
    private let expiryLabel = UILabel().then {
        $0.font = .as14BodyBold
        $0.textColor = .asMainOrange
        $0.numberOfLines = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = contentView.bounds.height / 2
    }
    
    override func setUpLayout() {
        [foodImageView, nameLabel, expiryLabel].forEach { contentView.addSubview($0) }
        
        foodImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(6)
            make.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(foodImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        expiryLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(6)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    override func setUpUI() {
        contentView.backgroundColor = .asWhite
    }
    
    func setUpData(data: FoodResponse) {
        foodImageView.setFoodImage(urlString: data.imageURL)
        
        nameLabel.text = data.name
        expiryLabel.text = data.expiryDate.dDayString()
        
    }
    
}
