//
//  HomeVC.swift
//  FoodKeeper
//
//  Created by 박성민 on 1/26/26.
//

import UIKit

import FoodKeeperFoundation

import SnapKit
import Then
import RxSwift

final class HomeVC: BaseVC {
    private let vm = HomeVM()
    
    private let testLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.font = .as26Title
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testLabel)
        testLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        print("\(testLabel.font)")
        print("홈 화면 실행 완료")
    }
    
}


private extension HomeVC {
    
}
