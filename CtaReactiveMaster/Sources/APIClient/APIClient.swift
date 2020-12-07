//
//  APIClient.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/05.
//

import Foundation

public class APIClient: NSObject {
    func request<T: Requestable>(_ requestable: T, completion: @escaping(Result<T.Model?, NewsAPIError>) -> Void) {
        guard let request = requestable.urlRequest else { return }
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                completion(.failure(NewsAPIError.unknown(error)))
            }
            guard let data = data, let _ = response else {
                completion(.failure(NewsAPIError.noResponse))
                return
            }
            do {
                let model = try? requestable.decode(from: data)
                completion(.success(model))
            } catch let decodeError {
                completion(.failure(NewsAPIError.decode(decodeError)))
            }
        })
        task.resume()
    }
}

public enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}

public enum NewsAPIError: Error {
    case decode(Error)
    case noResponse
    case unknown(Error)
}
