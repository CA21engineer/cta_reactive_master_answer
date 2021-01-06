//
//  UIViewController+Extension.swift
//  CtaReactiveMaster
//
//  Created by 伊藤凌也 on 2020/12/27.
//

import UIKit

extension UIViewController {
    func showIndicator() {
        let indicator = UIActivityIndicatorView(style: .large)
        view.addSubview(indicator)

        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        indicator.hidesWhenStopped = true

        indicator.startAnimating()
    }

    func hideIndicator() {
        view.subviews.forEach { subview in
            if let indicatorView = subview as? UIActivityIndicatorView {
                indicatorView.stopAnimating()
                indicatorView.removeFromSuperview()
            }
        }
    }
}
