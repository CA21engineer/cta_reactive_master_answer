//
//  APIClient.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/05.
//

import Foundation
import RxSwift

struct APIClient {
    func request<T: Requestable>(_ requestable: T) -> Single<T.Model> {
        guard let request = requestable.urlRequest else {
            return Single.error(NewsAPIError.requestNotFound)
        }
        return Single<T.Model>.create { single in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    single(.error(NewsAPIError.unknown(error)))
                } else if let data = data, response != nil {
                    do {
                        let model = try requestable.decode(from: data)
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
    case requestNotFound
}
