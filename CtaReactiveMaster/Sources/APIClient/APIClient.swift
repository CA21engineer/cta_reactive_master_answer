//
//  APIClient.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/05.
//

import Foundation

struct APIClient {
    let decoder: JSONDecoder

    func request<T: Requestable>(_ request: T, completion: @escaping (Result<T.Response, NewsAPIError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request.url, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(NewsAPIError.unknown(error)))
            }
            guard let data = data, response != nil else {
                completion(.failure(NewsAPIError.noResponse))
                return
            }
            do {
                let model = try decoder.decode(T.Response.self, from: data)
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
