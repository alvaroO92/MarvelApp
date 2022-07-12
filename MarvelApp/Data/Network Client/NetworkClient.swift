//
//  NetworkClient.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import Foundation

protocol Network {
    func load(request: NetworkRequest, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

class NetworkClient: Network {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func load(request: NetworkRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {

        guard Reachability.isConnectedToNetwork() else {
            completion(.failure(.networkConnection))
            return
        }

        do {
            let urlRequest = try request.asURLRequest()
            session.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, error == nil else {
                    if let error = error {
                        completion(.failure(.general(error)))
                    }
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.noHTTP))
                    return
                }

                guard 200 ... 299 ~= response.statusCode else {
                    completion(.failure(.status(response.statusCode)))
                    return
                }

                completion(.success(data))
            }.resume()

        } catch {
            completion(.failure(.general(error)))
        }
    }
}
