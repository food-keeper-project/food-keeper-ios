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
    private var isSyncingScroll = false
    private let expiringInfo = ExpiringInfoView()
    private let warningImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage.asDanger
    }
    
    private lazy var expiringFoodCV1: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: Int.max, height: 40)
        layout.minimumInteritemSpacing = 12 //세로 셀 간격
        layout.minimumLineSpacing = 8 //가로 셀 간격
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cv.register(ExpiringFoodCVCell.self, forCellWithReuseIdentifier: ExpiringFoodCVCell.id)
        return cv
    }()
    
    private lazy var expiringFoodCV2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: Int.max, height: 40)
        layout.minimumInteritemSpacing = 12 //세로 셀 간격
        layout.minimumLineSpacing = 8 //가로 셀 간격
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cv.register(ExpiringFoodCVCell.self, forCellWithReuseIdentifier: ExpiringFoodCVCell.id)
        return cv
    }()

    // 외부에서 데이터 주입
    let foods = PublishRelay<[FoodResponse]>()
    // 외부로 이벤트 전달
    let didSelectFood = PublishRelay<FoodResponse>()

    override func setUpLayout() {
        [expiringInfo, warningImage, expiringFoodCV1, expiringFoodCV2].forEach { self.addSubview($0) }
        expiringInfo.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(33)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(75)
        }
        
        warningImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(18)
            make.size.equalTo(80)
        }
        expiringFoodCV1.snp.makeConstraints { make in
            make.top.equalTo(expiringInfo.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(57)
        }
        expiringFoodCV2.snp.makeConstraints { make in
            make.top.equalTo(expiringFoodCV1.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
    }

    override func setUpUI() {
        backgroundColor = .asMainOrange
        expiringFoodCV1.delegate = self
        expiringFoodCV2.delegate = self
        bind()
    }

    private func bind() {

        let sharedFoods = foods.share()
        
        sharedFoods
            .map { $0.count }
            .bind(with: self, onNext: { owner, cnt in
                self.expiringInfo.expiringCount.text = "\(cnt)개"
            })
            .disposed(by: disposeBag)
        
        let split = sharedFoods
            .map { [weak self] foods -> ([FoodResponse], [FoodResponse]) in
                guard let self else { return ([], []) }
                return self.splitFoodsByWidth(foods)
            }
            .share()
        
        split
            .map { $0.0 }
            .bind(to: expiringFoodCV1.rx.items(
                cellIdentifier: ExpiringFoodCVCell.id,
                cellType: ExpiringFoodCVCell.self
            )) { _, item, cell in
                cell.setUpData(data: item)
            }
            .disposed(by: disposeBag)

        
        split
            .map { $0.1 }
            .bind(to: expiringFoodCV2.rx.items(
                cellIdentifier: ExpiringFoodCVCell.id,
                cellType: ExpiringFoodCVCell.self
            )) { _, item, cell in
                cell.setUpData(data: item)
            }
            .disposed(by: disposeBag)
        
        expiringFoodCV1.rx.modelSelected(FoodResponse.self)
            .bind { item in
                print("\(item.name) 클릭")
            }.disposed(by: disposeBag)
        
        expiringFoodCV2.rx.modelSelected(FoodResponse.self)
            .bind { item in
                print("\(item.name) 클릭")
            }.disposed(by: disposeBag)
    }
    
}
extension ExpiringFoodView: UICollectionViewDelegate {
    // 두개의 컬렉션 뷰에 아이템 분배를 위한 길이 계산 및 분리
    private func splitFoodsByWidth(_ foods: [FoodResponse]) -> ([FoodResponse], [FoodResponse]) {

        var row1: [FoodResponse] = []
        var row2: [FoodResponse] = []

        var row1Width = 0
        var row2Width = 0

        for food in foods {
            let width = food.name.count + food.expiryDate.dDayString().count

            if row1Width <= row2Width {
                row1.append(food)
                row1Width += width
            } else {
                row2.append(food)
                row2Width += width
            }
        }
        return (row1, row2)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isSyncingScroll else { return }

        isSyncingScroll = true

        if scrollView === expiringFoodCV1 {
            expiringFoodCV2.contentOffset = expiringFoodCV1.contentOffset
        } else if scrollView === expiringFoodCV2 {
            expiringFoodCV1.contentOffset = expiringFoodCV2.contentOffset
        }

        isSyncingScroll = false
    }
}
