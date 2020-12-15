//
//  +Extension.swift
//  CtaReactiveMaster
//
//  Created by Takuma Osada on 2020/12/15.
//

import Foundation

extension NSObject {
    static var className: String {
        guard let className = NSStringFromClass(self).components(separatedBy: ".").last else {
            fatalError("last index not found")
        }
        return className
    }
}
