//
//  MyPageVC.swift
//  FoodKeeper
//
//  Created by 박성민 on 2/24/26.
//

import UIKit

import FoodKeeperFoundation
import Domain

import SnapKit
import Then
import RxSwift
import RxCocoa
import RxDataSources

final class MyPageVC: BaseVC {
    private let tt = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpLayout() {
        view.addSubview(tt)
    }
    override func setUpUI() {
        tt.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tt.text = "마이페이지"
    }
}
