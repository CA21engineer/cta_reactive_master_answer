//
//  JsonDecoder+Extension.swift
//  CtaReactiveMaster
//
//  Created by Takuma Osada on 2020/12/14.
//

import Foundation

extension JSONDecoder {
    static let iso8601: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }()
}
