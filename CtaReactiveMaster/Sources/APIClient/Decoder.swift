//
//  Decoder.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/13.
//

import Foundation

protocol Decoder {
    associatedtype Model
    
    func decode(from data: Data) throws -> Model
}
