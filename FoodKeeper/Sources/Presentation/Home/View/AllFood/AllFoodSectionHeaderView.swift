//
//  AllFoodSectionHeaderView.swift
//  FoodKeeper
//
//  Created by 박성민 on 2/8/26.
//

import UIKit
import FoodKeeperFoundation
import SnapKit
import Then

final class AllFoodSectionHeaderView: UITableViewHeaderFooterView {
    private let createDateLabel = UILabel().then {
        $0.font = .as10CaptionBold
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    private let bottomLine = UIView().then {
        $0.backgroundColor = .asBlack
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .asBackground
        [createDateLabel, bottomLine].forEach { contentView.addSubview($0)}
        
        createDateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        bottomLine.snp.makeConstraints { make in
            make.height.equalTo(1.5)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }

    func configure(_ createDate: String) {
        createDateLabel.text = createDate
    }
}
