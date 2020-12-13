//
//  NewsAPIRequest.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/07.
//

import Foundation

struct NewsAPIRequest: Requestable {
    private let country: Country
    private let category: Category
    
    var url: URL {
        topHeadlinesURL()
    }

    init(country: Country, category: Category) {
        self.country = country
        self.category = category
    }
    
    func topHeadlinesURL() -> URL {
        var baseURL = URLComponents(string: "https://newsapi.org")
        let topHeadlinesPath = "/v2/top-headlines"
        
        var newsAPIKey: String {
            get {
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
        baseURL?.path = topHeadlinesPath
        baseURL?.queryItems = [URLQueryItem(name: "country", value: country.rawValue),
                               URLQueryItem(name: "category", value: category.rawValue),
                               URLQueryItem(name: "apiKey", value: newsAPIKey)
                              ]
        guard let requestURL = baseURL?.url else { return URL(string: "https")! }
        return requestURL
    }
}
