//
//  ObservableType.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 2/23/26.
//
#if canImport(UIKit)
import UIKit
import RxSwift
import RxCocoa
extension ObservableType {
    
    /// 에러 발생 시 기본값 반환 + 에러 이벤트 전달
    func catchAndReturn(
        _ value: Element,
        errorRelay: PublishRelay<Error>? = nil,
        logError: Bool = true
    ) -> Observable<Element> {
        return self.catch { error in
            if logError {
                Logger.error(error)
            }
            
            // 에러를 relay로 전달
            errorRelay?.accept(error)
            
            return .just(value)
        }
    }
    
    /// 로딩 상태 자동 관리 + 에러 전달
    func withLoading(
        _ loading: BehaviorRelay<Bool>,
        errorRelay: PublishRelay<Error>? = nil
    ) -> Observable<Element> {
        return self.do(
            onNext: { _ in
                loading.accept(false)
            },
            onError: { error in
                loading.accept(false)
                errorRelay?.accept(error)
            },
            onSubscribe: {
                loading.accept(true)
            },
            onDispose: {
                loading.accept(false)
            }
        )
        .catch { error in
            errorRelay?.accept(error)
            return .empty()
        }
    }
    
    /// Throttle with default scheduler
    func throttle(_ duration: RxTimeInterval) -> Observable<Element> {
        return throttle(duration, scheduler: MainScheduler.instance)
    }
}
#endif
