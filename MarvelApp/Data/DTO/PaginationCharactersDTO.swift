//
//  PaginationCharactersDTO.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import RealmSwift
import Foundation

final class PaginationCharactersDTO: Object, Codable {
    @objc dynamic var id: String?
    @objc dynamic var offset: Int = 0
    @objc dynamic var limit: Int = 0
    @objc dynamic var total: Int = 0
    @objc dynamic var count: Int = 0
    dynamic var results = List<CharacterDTO>()

    override class func primaryKey() -> String? {
        "id"
    }

    private enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }

    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        self.offset = try container.decode(Int.self, forKey: .offset)
        self.limit = try container.decode(Int.self, forKey: .limit)
        self.total = try container.decode(Int.self, forKey: .total)
        self.count = try container.decode(Int.self, forKey: .count)
        self.results = try container.decode(List<CharacterDTO>.self, forKey: .results)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(offset, forKey: .offset)
        try container.encode(limit, forKey: .limit)
        try container.encode(total, forKey: .total)
        try container.encode(count, forKey: .count)
        try container.encode(results, forKey: .results)
    }

    public func toDomain() -> PaginationCharacters {
        let characters: [Character] = results.compactMap { $0.toDomain() }
        return PaginationCharacters(id: id, results: characters)
    }
}
