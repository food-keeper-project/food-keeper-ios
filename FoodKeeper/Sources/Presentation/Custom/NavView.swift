//
//  NavView.swift
//  FoodKeeper
//
//  Created by 박성민 on 2/8/26.
//

import UIKit
import FoodKeeperFoundation

import SnapKit

final class NavTitleView: UIView {

    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()

    init(image: UIImage?, title: String) {
        super.init(frame: .zero)
        setupUI(image: image, title: title)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupUI(image: UIImage?, title: String) {
        iconImageView.image = image
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .asMainOrange

        titleLabel.text = title
        titleLabel.font = .as19TitleExtraBold
        titleLabel.textColor = .asMainOrange

        let stack = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        stack.axis = .horizontal
        stack.spacing = 6
        stack.alignment = .center

        addSubview(stack)
        stack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(27)
        }
    }
}
