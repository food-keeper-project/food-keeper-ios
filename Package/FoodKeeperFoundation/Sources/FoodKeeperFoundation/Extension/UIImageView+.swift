//
//  UIImageView+.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 2/7/26.
//

#if canImport(UIKit)
import UIKit
import Kingfisher

public extension UIImageView {
    // 음식 이미지
    func setFoodImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        self.kf.setImage(
            with: url,
            placeholder: UIImage.asAppLogo,
            options: [.transition(.fade(1.2))]
        )
    }
}
#endif
