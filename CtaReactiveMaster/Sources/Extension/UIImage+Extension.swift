//
//  UIImage+Extension.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/07.
//

import UIKit

extension UIImage {
    convenience init?(url: String) {
        guard let url = URL(string: url) else {
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        self.init(data: data)
    }
}
