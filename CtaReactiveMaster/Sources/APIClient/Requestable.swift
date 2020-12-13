//
//  Requestable.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/07.
//

import Foundation

protocol Requestable {
    var url: URL { get }
}

extension Requestable {
    var urlRequest: URLRequest? {
        let request = URLRequest(url: url)
        return request
    }
}
