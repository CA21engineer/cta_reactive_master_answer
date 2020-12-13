//
//  APIClient.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/05.
//

import Foundation

struct APIClient {
    func request<T: Requestable, U: Decoder>(_ requestable: T, _ decoder: U, completion: @escaping (Result<U.Model, NewsAPIError>) -> Void) {
        guard let request = requestable.urlRequest else { return }
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(NewsAPIError.unknown(error)))
            }
            guard let data = data, response != nil else {
                completion(.failure(NewsAPIError.noResponse))
                return
            }
            do {
                let model = try decoder.decode(from: data)
                completion(.success(model))
            } catch let decodeError {
                completion(.failure(NewsAPIError.decode(decodeError)))
            }
        })
        task.resume()
    }
}

enum NewsAPIError: Error {
    case decode(Error)
    case noResponse
    case unknown(Error)
}
