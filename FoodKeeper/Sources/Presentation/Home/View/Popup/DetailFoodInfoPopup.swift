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
    
    init(foodInfo: FoodResponse) {
        self.foodInfo = foodInfo
        super.init()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpLayout() {
        [infoPopup].forEach { view.addSubview($0) }
        
        
        infoPopup.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(50)
            make.centerY.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    override func setUpUI() {
        view.backgroundColor = .asBlack.withAlphaComponent(0.7)
    }
    
}
