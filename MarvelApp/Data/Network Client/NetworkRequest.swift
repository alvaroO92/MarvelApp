//
//  NetworkRequest.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

struct NetworkRequest {
    let method: HTTPMethod
    let parameters: [String: Any]?
    let headers: [String : String]?
    let url: String

    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: url) else {
            throw NetworkError.noHTTP
        }

        var urlComponents = URLComponents(string: url.absoluteString)
        urlComponents?.queryItems = parameters?.compactMap { URLQueryItem(name: $0, value: "\($1)") }
        var urlRequest = URLRequest(url: urlComponents?.url ?? url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
}
