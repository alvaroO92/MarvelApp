//
//  NetworkError.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import Foundation

enum NetworkError: Error, Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
    case status(Int)
    case general(Error)
    case json(Error)
    case noHTTP
    case networkConnection

    func description() -> String {
        switch self {
        case .networkConnection:
            return "alertConnectionError_message".localized
        default:
            return "alertDefaultError_message".localized
        }
    }
}
