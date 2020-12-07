//
//  Requestable.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/07.
//

import Foundation

protocol Requestable {
    associatedtype Model

    var url: URL { get }

    func decode(from data: Data) throws -> Model
}

extension Requestable {
    var urlRequest: URLRequest? {
        let request = URLRequest(url: url)
        return request
    }
}
