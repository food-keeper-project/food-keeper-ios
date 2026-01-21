//
//  BaseVC.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 1/21/26.
//

#if canImport(UIKit)
import UIKit

import RxSwift

open class BaseVC: UIViewController {
    public var disposeBag = DisposeBag()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpLayout()
        setUpNavigation()
        setUpDefaultUI()
    }
    
    open func setUpUI() { }
    open func setUpLayout() { }
    open func setUpNavigation() { }
    private func setUpDefaultUI() {
//        view.backgroundColor = Design.Color.background
    }
}
#endif
