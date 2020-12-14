//
//  NewsRepository.swift
//  CtaReactiveMaster
//
//  Created by Takuma Osada on 2020/12/14.
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
        let request = NewsAPIRequest(country: .jp, category: .technology)
        apiClient.request(request, decoder: .iso8601, completion: completion)
    }
}
