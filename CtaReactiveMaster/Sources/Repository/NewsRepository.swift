//
//  NewsRepository.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/17.
//

import Foundation
import RxSwift

protocol Repository {
    associatedtype Response
    var apiClient: APIClient { get }

    func fetch() -> Single<Response>
}

struct NewsRepository: Repository {
    typealias Response = NewsSource

    let apiClient = APIClient()

    func fetch() -> Single<Response> {
        let request = NewsAPIRequest(endpoint: .topHeadline, country: .jp, category: .technology)
        return apiClient.request(request)
    }
}
