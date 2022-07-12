//
//  MarvelCharactersResponseDTO.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import RealmSwift
import Foundation

final class MarvelCharactersResponseDTO: Object, Codable {
    @objc dynamic var id: String?
    @objc dynamic var code: Int = 0
    @objc dynamic var data: PaginationCharactersDTO?

    override class func primaryKey() -> String? {
        "id"
    }

    private enum CodingKeys: String, CodingKey {
        case code
        case data
    }

    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        self.code = try container.decode(Int.self, forKey: .code)
        self.data = try container.decode(PaginationCharactersDTO.self, forKey: .data)
    }

    public func toDomain() -> MarvelCharactersResponse {
        MarvelCharactersResponse(
            id: id,
            data: data?.toDomain()
        )
    }
}
