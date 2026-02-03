//
//  BaseTVCell.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 2/3/26.
//

#if canImport(UIKit)
import UIKit

open class BaseTVCell: UITableViewCell {
    public override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
        setUpLayout()
        setUpDefaultUI()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setUpUI() { }
    open func setUpLayout() { }
    private func setUpDefaultUI() {
        selectionStyle = .none
    }
}
#endif

