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
    
    private let scrollView = UIScrollView()
    private let floatingBtn = UIButton().then {
        $0.setTitle("AI", for: .normal)
        $0.titleLabel?.font = .as22TitleBold
        $0.backgroundColor = .asMainOrange
        $0.setTitleColor(.asWhite, for: .normal)
    }
    private let contentView = UIView()
    
    private let expiringFoodView = ExpiringFoodView()
    private let allFoodView = ExpiringFoodView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        floatingBtn.layer.cornerRadius = floatingBtn.bounds.width / 2
        floatingBtn.clipsToBounds = true
    }
    
    override func setUpLayout() {
        [scrollView, floatingBtn].forEach { view.addSubview($0) }
        [contentView].forEach { scrollView.addSubview($0) }
        [expiringFoodView, allFoodView].forEach { contentView.addSubview($0) }
        
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        floatingBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(54)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.size.equalTo(60)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        expiringFoodView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(300)
        }
        allFoodView.snp.makeConstraints { make in
            make.top.equalTo(expiringFoodView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
    }
    override func setUpUI() {
        scrollView.backgroundColor = .blue
        contentView.backgroundColor = .red
    }
    
}


private extension HomeVC {
    
}
