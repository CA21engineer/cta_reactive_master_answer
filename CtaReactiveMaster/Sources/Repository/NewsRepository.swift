//
//  NewsRepository.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/17.
//

import Foundation

protocol Repository {
    associatedtype Response
    var apiClient: APIClient { get }

    func fetch(completion: @escaping (Result<Response, NewsAPIError>) -> Void)
}

struct NewsRepository: Repository {
    typealias Response = NewsSource

    let apiClient = APIClient()

    func fetch(completion: @escaping (Result<NewsSource, NewsAPIError>) -> Void) {
        let request = NewsAPIRequest(endpoint: .topHeadline(country: .jp, category: .technology))
        apiClient.request(request, completion: completion)
    }
}
