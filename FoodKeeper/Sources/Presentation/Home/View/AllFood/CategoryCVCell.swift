//
//  CategoryCVCell.swift
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


final class CategoryCVCell: BaseCVCell {
    private var disposeBag = DisposeBag()
    private let nameLabel = UILabel().then {
        $0.font = .as14BodyBold
        $0.textColor = .asBlack
        $0.numberOfLines = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        updateSelectionUI(isSelected: false)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
    }
    
    override func setUpLayout() {
        [nameLabel].forEach { contentView.addSubview($0) }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    override func setUpUI() {
        contentView.backgroundColor = .asGray6
    }
    
    func setUpData(with model: CategorySectionItem) {
        updateSelectionUI(isSelected: model.isSelected)
        nameLabel.text = model.category.name
    }
    private func updateSelectionUI(isSelected: Bool) {
        if isSelected {
            nameLabel.textColor = .asWhite
            contentView.backgroundColor = .asMainOrange
        } else {
            nameLabel.textColor = .asBlack
            contentView.backgroundColor = .asGray6
        }
    }
    
}
