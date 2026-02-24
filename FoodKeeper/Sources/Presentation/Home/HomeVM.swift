//
//  HomeVM.swift
//  FoodKeeper
//
//  Created by 박성민 on 1/26/26.
//

import Foundation
import FoodKeeperFoundation
import RxSwift
import Domain

final class HomeVM: BaseVM {
    
    private let disposeBag = DisposeBag()
    
    @Injected private var foodUseCase: FoodUseCase
    @Injected private var categoryUseCase: CategoryUseCase
    private var saveAllFoodList: [FoodResponse] = []
    private let allCategory: FoodCategory = .init(id: -1, name: "전체")
    func transform(input: Input) -> Output {
        let output = Output()
        //첫 화면이 뜰 때 데이터 가져오기
        input.viewWillAppearEvent
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .do(onNext: { output.isLoading.onNext(true) })
            .flatMapLatest { [weak self] _ -> Observable<(expiring: [FoodResponse], all: [FoodResponse], categories: [FoodCategory])> in
                guard let self = self else { return .empty() }
                
                // ✅ Single.zip 사용
                return Single.zip(
                    self.foodUseCase.fetchExpiringFoods()
                        .catch { error in
                            print("❌ [HomeVM] fetchExpiringFoods error: \(error)")
                            output.error.onNext(error)
                            return .just([])
                        },
                    self.foodUseCase.fetchAllFoods()
                        .catch { error in
                            print("❌ [HomeVM] fetchAllFoods error: \(error)")
                            output.error.onNext(error)
                            return .just([])
                        },
                    self.categoryUseCase.fetchCategorys()
                        .catch { error in
                            print("❌ [HomeVM] fetchCategorys error: \(error)")
                            output.error.onNext(error)
                            return .just([])
                        }
                )
                .map { (expiring: $0, all: $1, categories: $2) }
                .asObservable()  // ✅ 마지막에 Observable로 변환
            }
            .do(onNext: { _ in output.isLoading.onNext(false) })
            .subscribe(onNext: { result in
                print("✅ [HomeVM] Data loaded - Expiring: \(result.expiring.count), All: \(result.all.count), Categories: \(result.categories.count)")
                
                output.expiringFoods.onNext(result.expiring)
                output.allFoods.onNext(result.all)
                self.saveAllFoodList = result.all
                var tmp = result.categories
                tmp.insert(self.allCategory, at: 0)
                output.selectedCategory.onNext(self.allCategory)
                output.categorys.onNext(tmp)
            })
            .disposed(by: disposeBag)
        //카테고리 클릭 이벤트
        input.changeSelectedCategory
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(with: self, onNext: { owner, item in
                output.selectedCategory.onNext(item)
                if item == self.allCategory {
                    output.allFoods.onNext(self.saveAllFoodList)
                } else {
                    output.allFoods.onNext(self.saveAllFoodList.filter { $0.categorys.contains(where: { $0.id == item.id })})
                }
            })
            .disposed(by: disposeBag)
            
        return output
    }
}

// MARK: - Input & Output

extension HomeVM {
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let changeSelectedCategory: Observable<FoodCategory>
    }
    
    struct Output {
        let isLoading = BehaviorSubject<Bool>(value: false)
        let error = PublishSubject<Error>()
        
        let expiringFoods = PublishSubject<[FoodResponse]>()
        let allFoods = PublishSubject<[FoodResponse]>()
        let categorys = PublishSubject<[FoodCategory]>()
        let selectedCategory = PublishSubject<FoodCategory>()
    }
}
