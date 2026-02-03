//
//  BaseView.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 2/3/26.
//

#if canImport(UIKit)
import UIKit

import RxSwift

open class BaseView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        setUpLayout()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setUpUI() { }
    open func setUpLayout() { }
}
#endif
