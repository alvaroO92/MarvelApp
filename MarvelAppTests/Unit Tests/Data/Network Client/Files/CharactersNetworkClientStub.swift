//
//  CharactersNetworkClientStub.swift
//  MarvelAppTests
//
//  Created by Alvaro Orti Moreno on 3/7/22.
//

import XCTest
@testable import MarvelApp

final class CharactersNetworkClientStub: CharacterListNetworkClientProtocol {

    let jsonName: String
    let networkError: NetworkError?

    init(jsonName: String, networkError: NetworkError?) {
        self.jsonName = jsonName
        self.networkError = networkError
    }

    func loadJson(fileName: String) -> Data? {

        guard
            let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: fileUrl) else {
            print("File could not be located at the given url")
            return nil
        }

        return data
    }

    func getCharacters(page: Int, completion: @escaping (Result<Data, NetworkError>) -> Void) {

        // If network error exists and is networkConnection
        if let networkError = networkError,
            networkError == .networkConnection {
            if let data = loadJson(fileName: jsonName) {
                completion(.success(data))
            }
            return
        }

        if let networkError = networkError {
            completion(.failure(networkError))
            return
        }

        if let data = loadJson(fileName: jsonName) {
            completion(.success(data))
        } else {
            completion(.failure(.json(NSError(domain: "", code: -999, userInfo: nil))))
        }
    }
}
