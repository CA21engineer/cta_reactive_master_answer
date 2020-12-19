//
//  Requestable.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/07.
//

import Foundation

protocol Requestable {
    associatedtype Response: Decodable
    var url: URL { get }
}
