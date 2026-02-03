//
//  ExpiringFoodView.swift
//  FoodKeeper
//
//  Created by 박성민 on 1/31/26.
//

import UIKit
import FoodKeeperFoundation

import SnapKit
import Then
import RxSwift
import RxCocoa

import Domain

final class ExpiringFoodView: BaseView {
    private let disposeBag = DisposeBag()

    private let expiringInfo = UILabel().then {
        $0.text = "유통기한 임박 식품\n현재 12개 보유중 입니다."
        $0.font = .as22TitleBold
        $0.textColor = .asWhite
        $0.numberOfLines = 2
    }
    private let warningImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage.colorAppLogo
    }
    
    private let tableView = UITableView()

    // 🔥 외부에서 주입
    let foods = PublishRelay<[FoodResponse]>()
    // 🔥 외부로 이벤트 전달
    let didSelectFood = PublishRelay<FoodResponse>()

    override func setUpLayout() {
        addSubview(tableView)
        [expiringInfo, warningImage, tableView].forEach { self.addSubview($0) }
        expiringInfo.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(33)
            make.leading.equalToSuperview().inset(20)
        }
        
        warningImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(31)
            make.trailing.equalToSuperview().inset(18)
            make.size.equalTo(80)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(expiringInfo.snp.bottom).offset(28)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(90)
        }
    }

    override func setUpUI() {
        backgroundColor = .asMainOrange
        tableView.backgroundColor = .clear
        tableView.register(
            ExpiringFoodCell.self,
            forCellReuseIdentifier: ExpiringFoodCell.id
        )

        bind()
    }

    private func bind() {

        // 데이터 바인딩
        foods
            .bind(to: tableView.rx.items(
                cellIdentifier: ExpiringFoodCell.id,
                cellType: ExpiringFoodCell.self
            )) { _, item, cell in
                cell.configure(item)
            }
            .disposed(by: disposeBag)

        // 셀 선택 이벤트
        tableView.rx.modelSelected(FoodResponse.self)
            .bind(to: didSelectFood)
            .disposed(by: disposeBag)
    }
}
