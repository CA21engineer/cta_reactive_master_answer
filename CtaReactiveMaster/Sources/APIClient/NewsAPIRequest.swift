//
//  NewsAPIRequest.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/07.
//

import Foundation

enum Key {
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

enum Endpoint: String {
    case topHeadline = "/v2/top-headlines"
    case sources = "/v2/sources"
    // Todo: case everything = "/v2/everything"
}

struct NewsAPIRequest: Requestable {
    typealias Response = NewsSource

    private let endpoint: Endpoint
    private let country: Country
    private let category: Category
    
    var url: URL {
        var baseURL = URLComponents(string: "https://newsapi.org")!
        
        baseURL.path = endpoint.rawValue
        baseURL.queryItems = [
            URLQueryItem(name: "country", value: country.rawValue),
            URLQueryItem(name: "category", value: category.rawValue),
            URLQueryItem(name: "apiKey", value: Key.newsApi)
        ]
        return baseURL.url!
    }

    init(
        endpoint: Endpoint,
        country: Country,
        category: Category
    ) {
        self.endpoint = endpoint
        self.country = country
        self.category = category
    }
}
