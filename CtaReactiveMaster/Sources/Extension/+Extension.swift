//
//  +Extension.swift
//  CtaReactiveMaster
//
//  Created by Takuma Osada on 2020/12/15.
//

import Foundation

extension NSObject {
    static var className: String {
        String(describing: self)
    }
}
