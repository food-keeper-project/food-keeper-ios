//
//  BaseCVCell.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 2/3/26.
//

#if canImport(UIKit)
import UIKit

open class BaseCVCell: UICollectionViewCell {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
        setUpUI()
        
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    open func setUpLayout() { }
    open func setUpUI() { }
}
#endif
