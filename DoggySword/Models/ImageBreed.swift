//
//  Dog.swift
//  DoggySword
//
//  Created by Helder Nunes on 26/01/2024.
//

import Foundation

struct ImageBreed: Codable, Hashable, Identifiable {

    let id: String
    let url: URL?
    let width: CGFloat?
    let height: CGFloat?

    let breeds: [Breed]

    enum CodingKeys: String, CodingKey {

        case id
        case url
        case width
        case height
        case breeds
    }

    init(id: String, url: URL, width: CGFloat?, height: CGFloat?, breeds: [Breed]) {
        
        self.id = id
        self.url = url
        self.width = width
        self.height = height
        self.breeds = breeds
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        do {

            self.id = try container.decode(String.self, forKey: .id)

        } catch DecodingError.typeMismatch {

            let id = try container.decode(Int.self, forKey: .id)
            self.id = String(id)
        }

        self.url = try container.decode(URL.self, forKey: .url)
        self.width = try container.decodeIfPresent(CGFloat.self, forKey: .width)
        self.height = try container.decodeIfPresent(CGFloat.self, forKey: .height)
        self.breeds = try container.decode([Breed].self, forKey: .breeds)
    }
}
