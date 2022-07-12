//
//  NetworkClientStub.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

final class NetworkClientStub: Network {

    let forceError: NetworkError?

    init(forceError: NetworkError? = nil) {
        self.forceError = forceError
    }

    func load(request: NetworkRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {

        guard let forceError = forceError else {
            let data = Data(request.url.utf8)
            completion(.success(data))
            return
        }
        completion(.failure(forceError))
    }
}
