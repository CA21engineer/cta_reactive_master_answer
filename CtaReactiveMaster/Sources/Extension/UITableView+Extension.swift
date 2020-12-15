//
//  UITableView+Extension.swift
//  CtaReactiveMaster
//
//  Created by Takuma Osada on 2020/12/15.
//

import UIKit

extension UITableView {
    func registerNib<T: UITableViewCell>(_ type: T.Type) {
        let nib = UINib(nibName: type.className, bundle: nil)
        register(nib, forCellReuseIdentifier: type.className)
    }

    func registerClass<T: UITableViewCell>(_ type: T.Type) {
        register(T.self, forCellReuseIdentifier: type.className)
    }

    func dequeue<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell")
        }
        return cell
    }
}
