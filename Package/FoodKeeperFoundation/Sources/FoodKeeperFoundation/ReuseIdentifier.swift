//
//  ReuseIdentifier.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 1/21/26.
//

#if canImport(UIKit)
import UIKit

protocol ReuseIdentifiable {
    static var id: String { get }
}

extension ReuseIdentifiable {
    static var id: String { String(describing: Self.self) }
}

extension NSObject: ReuseIdentifiable { }

public extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(
        cellType: T.Type,
        for indexPath: IndexPath
    ) -> T {
        dequeueReusableCell(
            withIdentifier: cellType.id,
            for: indexPath
        ) as! T
    }
}
#endif
