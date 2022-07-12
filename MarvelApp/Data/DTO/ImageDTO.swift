//
//  ImageDTO.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import RealmSwift
import Foundation

final class ImageDTO: Object, Codable {
    @objc dynamic var id: String?
    @objc dynamic var path: String = ""
    @objc dynamic var ext: String = ""

    override class func primaryKey() -> String? {
        "id"
    }

    private enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }

    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        self.path = try container.decode(String.self, forKey: .path)
        self.ext = try container.decode(String.self, forKey: .ext)
    }
}

extension ImageDTO {

    func toDomain() -> Image {
        return Image(url: URL(string: "\(path).\(ext)"))
    }
}
