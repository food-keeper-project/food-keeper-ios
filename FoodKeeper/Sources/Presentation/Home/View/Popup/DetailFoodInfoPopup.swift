//
//  DetailFoodInfoPopup.swift
//  FoodKeeper
//
//  Created by psm on 3/24/26.
//

import UIKit

import FoodKeeperFoundation
import Domain

import SnapKit
import Then
import RxSwift
import RxCocoa
import RxDataSources

final class DetailFoodInfoPopup: BaseVC {
    private var foodInfo: FoodResponse
    
    private let infoPopup = UIView().then {
        $0.backgroundColor = .asBackground
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = Design.Radius.medium_20
    }
    private let infoTitle = UILabel().then {
        $0.text = "식재료 상세보기"
        $0.font = .as16BodyBold
        $0.textColor = .asBlack
        $0.textAlignment = .left
    }
    private let dismissBtn = UIButton().then {
        $0.setImage(.asXmark, for: .normal)
    }
    
    init(foodInfo: FoodResponse) {
        self.foodInfo = foodInfo
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setUpLayout() {
        [infoPopup].forEach { view.addSubview($0) }
        [infoTitle, dismissBtn].forEach { infoPopup.addSubview($0) }
        
        
        infoPopup.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(50)
            make.centerY.equalToSuperview()
            make.height.lessThanOrEqualTo(UIScreen.main.bounds.height * 0.8)
        }
        infoTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(33)
            make.horizontalEdges.equalToSuperview().inset(Design.Padding.regular_22)
            make.bottom.equalToSuperview().inset(33)
        }
        dismissBtn.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(15)
        }
    }
    override func setUpUI() {
        view.backgroundColor = .asBlack.withAlphaComponent(0.7)
    }
    private func bind() {
        dismissBtn.rx.tap
            .subscribe(with: self) { owner, _ in
                print("버튼 클릭")
                owner.dismiss(animated: true)
            }.disposed(by: disposeBag)
    }
    
}
