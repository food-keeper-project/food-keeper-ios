//
//  HomeVC.swift
//  FoodKeeper
//
//  Created by 박성민 on 1/26/26.
//

import UIKit

import FoodKeeperFoundation
import Domain

import SnapKit
import Then
import RxSwift
import RxCocoa

final class HomeVC: BaseVC {
    private let vm = HomeVM()
    // stickyHeaderView 레이아웃 완료 트리거
    private var headerTriggerOffset: CGFloat = .greatestFiniteMagnitude
    // stickyHeaderView 스크롤 싱크
    private var isSyncingScroll = false
    
    private let scrollView = UIScrollView()
    private let floatingBtn = UIButton().then {
        $0.setTitle("AI", for: .normal)
        $0.titleLabel?.font = .as22TitleBold
        $0.backgroundColor = .asMainOrange
        $0.setTitleColor(.asWhite, for: .normal)
    }
    private let contentView = UIView()
    
    private let expiringFoodView = ExpiringFoodView()
    private let expiringEmptyView = UIView().then {
        $0.backgroundColor = .asWhite
    }
    
    private let categoryHeaderLabel = UILabel().then {
        $0.text = "나의 식재료 리스트"
        $0.font = .as22TitleBold
        $0.textColor = .asBlack
        $0.textAlignment = .left
    }
    private lazy var stickyHeaderView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 8 //가로 셀 간격
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cv.register(CategoryCVCell.self, forCellWithReuseIdentifier: CategoryCVCell.id)
        return cv
    }()
    private lazy var categoryListCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 8 //가로 셀 간격
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cv.register(CategoryCVCell.self, forCellWithReuseIdentifier: CategoryCVCell.id)
        return cv
    }()
    
    private let allFoodView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        stickyHeaderView.delegate = self
        categoryListCV.delegate = self
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        floatingBtn.layer.cornerRadius = floatingBtn.bounds.width / 2
        floatingBtn.clipsToBounds = true
        headerTriggerOffset = categoryListCV.frame.minY
    }
    
    override func setUpLayout() {
        [scrollView, stickyHeaderView, floatingBtn].forEach { view.addSubview($0) }
        [contentView].forEach { scrollView.addSubview($0) }
        [expiringFoodView, expiringEmptyView, allFoodView, categoryHeaderLabel, categoryListCV].forEach { contentView.addSubview($0) }
        
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        stickyHeaderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(30)
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
            make.height.equalTo(270)
        }
        expiringEmptyView.snp.makeConstraints { make in
            make.top.equalTo(expiringFoodView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(35)
        }
        categoryHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(expiringEmptyView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        categoryListCV.snp.makeConstraints { make in
            make.top.equalTo(categoryHeaderLabel.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(30)
        }
        allFoodView.snp.makeConstraints { make in
            make.top.equalTo(categoryListCV.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(3500)
        }
        
    }
    override func setUpUI() {
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        stickyHeaderView.isHidden = true
        contentView.backgroundColor = .asBackground
        
    }
    private func bind() {
        let input = HomeVM.Input(viewWillAppearEvent: viewWillAppearEvent)
        let output = vm.transform(input: input)
        
        
        output.expiringFoods
            .bind(to: expiringFoodView.foods)
            .disposed(by: disposeBag)
        
        // stickyHeaderView 바인딩
        output.categorys
            .bind(to: stickyHeaderView.rx.items(cellIdentifier: CategoryCVCell.id, cellType: CategoryCVCell.self)) { row, category, cell in
                cell.setUpData(data: category)
            }
            .disposed(by: disposeBag)
        
        // CategoryListCV 바인딩
        output.categorys
            .bind(to: categoryListCV.rx.items(cellIdentifier: CategoryCVCell.id, cellType: CategoryCVCell.self)) { row, category, cell in
                cell.setUpData(data: category)
            }
            .disposed(by: disposeBag)

    }
    
}
extension HomeVC: UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        // sticky 표시 로직은 메인 scrollView에서만
        if scrollView === self.scrollView {
            guard headerTriggerOffset != .greatestFiniteMagnitude else { return }

            let shouldShowSticky = scrollView.contentOffset.y >= headerTriggerOffset
            stickyHeaderView.isHidden = !shouldShowSticky
            categoryListCV.isHidden = shouldShowSticky
        }

        // 가로 스크롤 싱크는 컬렉션뷰끼리만
        guard !isSyncingScroll else { return }

        isSyncingScroll = true

        if scrollView === stickyHeaderView {
            categoryListCV.contentOffset = stickyHeaderView.contentOffset
        } else if scrollView === categoryListCV {
            stickyHeaderView.contentOffset = categoryListCV.contentOffset
        }

        isSyncingScroll = false
    }
}

private extension HomeVC {
    
}
