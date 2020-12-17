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

enum Endpoint {
    case topHeadline(country: Country, category: Category)
    case sources(q: String)
    case everything(country: Country, category: Category, language: Language)
    func endpoint() -> String {
        switch self {
        case .topHeadline:
            return "/v2/top-headlines"
        case .sources:
            return "/v2/sources"
        case .everything:
            return "/v2/everything"
        }
    }
}

struct NewsAPIRequest: Requestable {
    typealias Response = NewsSource

    private let endpoint: Endpoint
    
    var url: URL {
        var baseURL = URLComponents(string: "https://newsapi.org")!
        baseURL.path = endpoint.endpoint()

        switch endpoint {
        case let .topHeadline(country, category):
            baseURL.queryItems = [
                URLQueryItem(name: "country", value: country.rawValue),
                URLQueryItem(name: "category", value: category.rawValue),
                URLQueryItem(name: "apiKey", value: Key.newsApi)
            ]
        case let .sources(q):
            baseURL.queryItems = [
                URLQueryItem(name: "q", value: q)
            ]
        case let .everything(country, category, language):
            baseURL.queryItems = [
                URLQueryItem(name: "country", value: country.rawValue),
                URLQueryItem(name: "category", value: category.rawValue),
                URLQueryItem(name: "language", value: language.rawValue),
                URLQueryItem(name: "apiKey", value: Key.newsApi)
            ]
        }
        return baseURL.url!
    }

    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
}
