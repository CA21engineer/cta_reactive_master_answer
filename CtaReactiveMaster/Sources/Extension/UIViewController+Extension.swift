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
        indicator.center = view.center
        indicator.hidesWhenStopped = true

        view.addSubview(indicator)

        indicator.startAnimating()
    }

    func hideIndicator() {
        view.subviews.forEach { subview in
            if let indicatorView = subview as? UIActivityIndicatorView {
                indicatorView.stopAnimating()
            }
        }
    }
}
