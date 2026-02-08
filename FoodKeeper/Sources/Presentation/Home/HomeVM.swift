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
    func transform(input: Input) -> Output {
        let output = Output(
            expiringFoods: PublishSubject(),
            allFoods: PublishSubject(),
            categorys: PublishSubject(),
            selectedCategory: PublishSubject(),
        )
        input.viewWillAppearEvent
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { (_, _) in
                // 목데이터
                let mockFoods = FoodResponse.mockList
                var mockCategories = [FoodCategory(id: -1, name: "전체")]
                mockCategories.append(contentsOf: FoodCategory.mockList)
                
                // Output으로 전달
                output.expiringFoods.onNext(mockFoods)
                output.allFoods.onNext(mockFoods)
                output.categorys.onNext(mockCategories)
                output.selectedCategory.onNext(FoodCategory(id: -1, name: "전체"))
            })
            .disposed(by: disposeBag)
        return output
    }
    
}
extension HomeVM {
    struct Input {
        let viewWillAppearEvent: Observable<Void>
//        let tapFoodItme: PublishSubject<FoodResponse>
    }
    struct Output {
        let expiringFoods: PublishSubject<[FoodResponse]>
        let allFoods: PublishSubject<[FoodResponse]>
        let categorys: PublishSubject<[FoodCategory]>
        let selectedCategory: PublishSubject<FoodCategory>
    }
}
