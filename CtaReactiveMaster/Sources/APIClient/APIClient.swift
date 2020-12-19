//
//  APIClient.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/05.
//

import Foundation
import RxSwift

struct APIClient {
    let decoder: JSONDecoder

    func request<T: Requestable>(_ request: T) -> Single<T.Response> {
        Single<T.Response>.create { single in
            let task = URLSession.shared.dataTask(with: request.urlRequest) { data, response, error in
                if let error = error {
                    single(.error(NewsAPIError.unknown(error)))
                } else if let data = data, response != nil {
                    do {
                        let model = try decoder.decode(T.Response.self, from: data)
                        single(.success(model))
                    } catch {
                        single(.error(NewsAPIError.decode(error)))
                    }
                } else {
                    single(.error(NewsAPIError.noResponse))
                }
            }
            task.resume()
            return Disposables.create()
        }
    }
}

enum NewsAPIError: Error {
    case decode(Error)
    case noResponse
    case unknown(Error)
}
