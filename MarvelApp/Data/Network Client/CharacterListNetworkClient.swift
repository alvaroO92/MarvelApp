//
//  CharacterListNetworkClient.swift
//  MarvelApp
//
// Created by Alvaro Orti Moreno on 1/7/22.
//

import Foundation

protocol CharacterListNetworkClientProtocol: AnyObject {
    func getCharacters(page: Int, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

final class CharacterListNetworkClient {
    enum EndPoints: String {
        case characters = "characters"
    }

    let baseURL: String
    let session: URLSession

    init(baseURL: String, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
}

extension CharacterListNetworkClient: CharacterListNetworkClientProtocol {
    func getCharacters(page: Int, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let ts = Date().timeIntervalSince1970.description
        let hash = "\(ts)\(Constants.privateKey)\(Constants.publicKey)".md5
        let limit = Constants.limit

        let parameters = [
            "ts": ts,
            "apikey" : Constants.publicKey,
            "hash": hash,
            "limit": limit,"offset": "\(page)"]
        let url = baseURL + EndPoints.characters.rawValue

        let request = NetworkRequest(method: .get,
                                     parameters: parameters,
                                     headers: nil,
                                     url: url)
        NetworkClient(session: session).load(request: request) { (response: Result<Data, NetworkError>) in
            switch response {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
