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
import RxDataSources

final class HomeVC: BaseVC {
    private let vm = HomeVM()
    private var isSyncingScroll = false
    
    private let floatingBtn = UIButton().then {
        $0.setTitle("AI", for: .normal)
        $0.titleLabel?.font = .as22TitleBold
        $0.backgroundColor = .asMainOrange
        $0.setTitleColor(.asWhite, for: .normal)
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let expiringFoodView = ExpiringFoodView()
    private let expiringEmptyView = UIView().then {
        $0.backgroundColor = .asBackground
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
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: 500, height: 30)
        layout.minimumLineSpacing = 8
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .asBackground
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cv.register(CategoryCVCell.self, forCellWithReuseIdentifier: CategoryCVCell.id)
        return cv
    }()
    
    private lazy var categoryListCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: 500, height: 30)
        layout.minimumLineSpacing = 8
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cv.register(CategoryCVCell.self, forCellWithReuseIdentifier: CategoryCVCell.id)
        return cv
    }()
    
    private lazy var allFoodTV: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(AllFoodTVCell.self, forCellReuseIdentifier: AllFoodTVCell.id)
        tv.register(AllFoodSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: AllFoodSectionHeaderView.id)
        tv.rx.setDelegate(self).disposed(by: disposeBag)
        tv.rowHeight = 94
        tv.separatorStyle = .none
        tv.backgroundColor = .asBackground
        tv.showsVerticalScrollIndicator = false
        
        if #available(iOS 15.0, *) {
            tv.sectionHeaderTopPadding = 0
        }
        return tv
    }()
    
    private lazy var tableHeaderContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = .asBackground
        return container
    }()
    
    private var dataSource: RxTableViewSectionedReloadDataSource<AllFoodSection>!
    private let selectedCategorySubject = PublishSubject<FoodCategory>()
    
    private let stickyHeaderHeight: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stickyHeaderView.delegate = self
        categoryListCV.delegate = self
        allFoodTV.delegate = self
        
        // 처음에는 inset 0으로 시작 → 빈 공간 방지
        allFoodTV.contentInset.top = 0
        allFoodTV.verticalScrollIndicatorInsets.top = 0
        allFoodTV.scrollIndicatorInsets = allFoodTV.contentInset
        
        configureDataSource()
        setupTableHeaderView()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        floatingBtn.layer.cornerRadius = floatingBtn.bounds.width / 2
        floatingBtn.clipsToBounds = true
    }
    
    override func setUpLayout() {
        [allFoodTV, stickyHeaderView, floatingBtn].forEach { view.addSubview($0) }
        
        stickyHeaderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(stickyHeaderHeight)
        }
        
        floatingBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(54)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.size.equalTo(60)
        }
        
        allFoodTV.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func setUpUI() {
        stickyHeaderView.isHidden = true
        scrollView.backgroundColor = .asBackground
        contentView.backgroundColor = .asBackground
    }
    
    private func setupTableHeaderView() {
        [expiringFoodView, expiringEmptyView, categoryHeaderLabel, categoryListCV].forEach {
            tableHeaderContainerView.addSubview($0)
        }
        
        expiringFoodView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(270)
        }
        
        expiringEmptyView.snp.makeConstraints { make in
            make.top.equalTo(expiringFoodView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(30)
        }
        
        categoryHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(expiringEmptyView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        categoryListCV.snp.makeConstraints { make in
            make.top.equalTo(categoryHeaderLabel.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(stickyHeaderHeight)
            make.bottom.equalToSuperview().inset(20)
        }
        
        tableHeaderContainerView.layoutIfNeeded()
        
        let headerHeight = tableHeaderContainerView.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize
        ).height
        
        tableHeaderContainerView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: headerHeight
        )
        
        allFoodTV.tableHeaderView = tableHeaderContainerView
    }
    
    private func bind() {
        let categorySelection = Observable.merge(
            stickyHeaderView.rx.modelSelected(CategorySectionItem.self).map{$0.category}.asObservable(),
            categoryListCV.rx.modelSelected(CategorySectionItem.self).map{$0.category}.asObservable()
        )
        
        let input = HomeVM.Input(
            viewWillAppearEvent: viewWillAppearEvent,
            changeSelectedCategory: categorySelection
        )
        
        let output = vm.transform(input: input)
        
        // 유통기한 임박 식품
        output.expiringFoods
            .observe(on: MainScheduler.instance)
            .bind(to: expiringFoodView.foods)
            .disposed(by: disposeBag)
        
        // 카테고리 리스트 + 선택 상태를 결합한 모델 스트림
            let categoryModels = Observable.combineLatest(
                output.categorys,
                output.selectedCategory
            )
            .map { categories, selected -> [CategorySectionItem] in
                return categories.map { category in
                    CategorySectionItem(
                        category: category,
                        isSelected: category.id == selected.id
                    )
                }
            }
            .share(replay: 1)  // 여러 구독자 공유 + 재구독 시 캐시

            // stickyHeaderView 바인딩 (한 번만!)
            categoryModels
                .observe(on: MainScheduler.instance)
                .bind(to: stickyHeaderView.rx.items(
                    cellIdentifier: CategoryCVCell.id,
                    cellType: CategoryCVCell.self
                )) { _, model, cell in
                    cell.setUpData(with: model)  // ← setUpData 대신 configure 메서드 추천
                }
                .disposed(by: disposeBag)

            // categoryListCV 바인딩 (동일한 스트림 재사용)
            categoryModels
                .observe(on: MainScheduler.instance)
                .bind(to: categoryListCV.rx.items(
                    cellIdentifier: CategoryCVCell.id,
                    cellType: CategoryCVCell.self
                )) { _, model, cell in
                    cell.setUpData(with: model)
                }
                .disposed(by: disposeBag)
        
        // 전체 식품 리스트
        output.allFoods
            .observe(on: MainScheduler.instance)
            .map { foods -> [AllFoodSection] in
                let grouped = Dictionary(grouping: foods) {
                    $0.createdAt.toyyMMddString()
                }
                
                return grouped
                    .map { (dateString, foods) in
                        AllFoodSection(
                            header: dateString,
                            items: foods.sorted { $0.createdAt > $1.createdAt }
                        )
                    }
                    .sorted { $0.header > $1.header }
            }
            .bind(to: allFoodTV.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func configureDataSource() {
        dataSource = RxTableViewSectionedReloadDataSource<AllFoodSection>(
            configureCell: { _, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: AllFoodTVCell.id,
                    for: indexPath
                ) as! AllFoodTVCell
                cell.setUpData(data: item)
                return cell
            }
        )
    }
}

extension HomeVC: UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView === allFoodTV else {
            guard !isSyncingScroll else { return }
            isSyncingScroll = true
            
            if scrollView === stickyHeaderView {
                categoryListCV.contentOffset = stickyHeaderView.contentOffset
            } else if scrollView === categoryListCV {
                stickyHeaderView.contentOffset = categoryListCV.contentOffset
            }
            
            isSyncingScroll = false
            return
        }
        
        let offsetY = scrollView.contentOffset.y
        let triggerPoint = tableHeaderContainerView.frame.height - stickyHeaderHeight - 20
        
        let shouldShowSticky = offsetY >= triggerPoint
        
        if shouldShowSticky != !stickyHeaderView.isHidden {
            UIView.animate(withDuration: 0.15) {
                self.stickyHeaderView.isHidden = !shouldShowSticky
                self.categoryListCV.isHidden = shouldShowSticky
                
                // sticky가 나타나거나 사라질 때 inset 동적으로 조정
                let targetInset: CGFloat = shouldShowSticky ? self.stickyHeaderHeight : 0
                self.allFoodTV.contentInset.top = targetInset
                self.allFoodTV.verticalScrollIndicatorInsets.top = targetInset
                self.allFoodTV.scrollIndicatorInsets = self.allFoodTV.contentInset
            }
        }
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: AllFoodSectionHeaderView.id
        ) as! AllFoodSectionHeaderView
        
        let sectionModel = dataSource.sectionModels[section]
        header.setUp(title: sectionModel.header)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}
