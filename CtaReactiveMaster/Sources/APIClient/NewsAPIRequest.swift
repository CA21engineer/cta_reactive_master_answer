//
//  NewsAPIRequest.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/07.
//

import Foundation

enum Keys {
    static var newsApi: String {
        guard let filePath = Bundle.main.path(forResource: "APIKey", ofType: "plist") else {
            fatalError("Couldn't find file 'APIKey.plist'")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "newsAPIKey") as? String else {
            fatalError("Couldn't find key 'newsAPIKey' in 'APIKey.plist'")
        }
        return value
    }
}

struct NewsAPIRequest: Requestable {
    typealias Response = NewsSource

    private let country: Country
    private let category: Category
    
    var url: URL {
        var baseURL = URLComponents(string: "https://newsapi.org")!
        let topHeadlinesPath = "/v2/top-headlines"
        baseURL.path = topHeadlinesPath
        baseURL.queryItems = [
            URLQueryItem(name: "country", value: country.rawValue),
            URLQueryItem(name: "category", value: category.rawValue),
            URLQueryItem(name: "apiKey", value: Keys.newsApi)
        ]
        return baseURL.url!
    }

    init(country: Country, category: Category) {
        self.country = country
        self.category = category
    }
}
