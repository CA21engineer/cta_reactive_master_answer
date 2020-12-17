//
//  NewsAPIDecoder.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/13.
//

import Foundation

struct NewsAPIDecoder: Decoder {
    typealias Model = NewsSource
    
    func decode(from data: Data) throws -> NewsSource {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return try jsonDecoder.decode(Model.self, from: data)
    }
}
