//
//  PaddingLabel.swift
//  FoodKeeper
//
//  Created by 박성민 on 2/7/26.
//

import UIKit
import FoodKeeperFoundation

final class InsetLabel: UILabel {

    // MARK: - Public Properties

    /// 텍스트 내부 여백
    var contentInsets: UIEdgeInsets = .zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    /// 코너 둥글기
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    /// 테두리
    var borderWidth: CGFloat = 0 {
        didSet { layer.borderWidth = borderWidth }
    }
    //배경색
    var borderColor: UIColor? {
        didSet { layer.borderColor = borderColor?.cgColor }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        numberOfLines = 1
    }

    // MARK: - Layout

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: contentInsets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + contentInsets.left + contentInsets.right,
            height: size.height + contentInsets.top + contentInsets.bottom
        )
    }
}

extension InsetLabel {

    enum Style {
        case dDayBadge // 디데이
        case tag // 식재료 갯수
        case epiringBadge // 유통기한
    }

    func apply(style: Style) {
        switch style {
        case .dDayBadge:
            contentInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            cornerRadius = 4
            backgroundColor = .asMainOrange
            textColor = .asWhite
            font = .as12CaptionBold

        case .tag:
            contentInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
            cornerRadius = 6
            backgroundColor = .asWhite
            textColor = .asMainOrange
            font = .as19ExtraLargeTitle

        case .epiringBadge:
            contentInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            cornerRadius = 9
            backgroundColor = .asAccentYellow
            textColor = .asBlack
            font = .as10Caption
        }
    }
}
