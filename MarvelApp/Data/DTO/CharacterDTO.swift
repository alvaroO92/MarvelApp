//
//  CharacterDTO.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import RealmSwift
import Foundation

final class CharacterDTO: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var descrip: String = ""
    @objc dynamic var thumbnail: ImageDTO?
    @objc dynamic var resourceURI: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case descrip = "description"
        case thumbnail
        case resourceURI
    }

    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.descrip = try container.decode(String.self, forKey: .descrip)
        self.thumbnail = try container.decodeIfPresent(ImageDTO.self, forKey: .thumbnail)
        self.resourceURI = try container.decode(String.self, forKey: .resourceURI)
    }

    public func toDomain() -> Character {
        Character(
            id: id,
            name: name,
            description: descrip,
            thumbnail: thumbnail?.toDomain(),
            resourceURI: resourceURI
        )
    }
}
