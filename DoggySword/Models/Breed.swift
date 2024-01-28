//
//  Breed.swift
//  DoggySword
//
//  Created by Helder Nunes on 28/01/2024.
//

import Foundation

struct Breed: Codable, Hashable, Identifiable {

    let id: Int
    let name: String
    let bredFor: String?
    let breedGroup: String?
    let lifeSpan: String
    let temperement: String?
    let referenceImageId: String
    let origin: String?
    let countryCode: String?

    let weight: Eight
    let height: Eight

    enum CodingKeys: String, CodingKey {

        case id
        case name
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament
        case referenceImageId = "reference_image_id"
        case origin = "origin"
        case countryCode = "country_code"

        case weight
        case height
    }

    init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.lifeSpan = try values.decode(String.self, forKey: .lifeSpan)
        self.referenceImageId = try values.decode(String.self, forKey: .referenceImageId)
        self.weight = try values.decode(Eight.self, forKey: .weight)
        self.height = try values.decode(Eight.self, forKey: .height)

        if values.contains(.bredFor) {

            self.bredFor = try values.decode(String.self, forKey: .bredFor)

        } else {

            self.bredFor = nil
        }

        if values.contains(.breedGroup) {

            self.breedGroup = try values.decode(String.self, forKey: .breedGroup)

        } else {

            self.breedGroup = nil
        }

        if values.contains(.temperament) {

            self.temperement = try values.decode(String.self, forKey: .temperament)

        } else {

            self.temperement = nil
        }

        if values.contains(.origin) {

            self.origin = try values.decode(String.self, forKey: .origin)

        } else {

            self.origin = nil
        }

        if values.contains(.countryCode) {

            self.countryCode = try values.decode(String.self, forKey: .countryCode)

        } else {

            self.countryCode = nil
        }
    }

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.bredFor, forKey: .bredFor)
        try container.encode(self.breedGroup, forKey: .breedGroup)
        try container.encode(self.lifeSpan, forKey: .lifeSpan)
        try container.encode(self.temperement, forKey: .temperament)
        try container.encode(self.referenceImageId, forKey: .referenceImageId)
        try container.encode(self.origin, forKey: .origin)
        try container.encode(self.countryCode, forKey: .countryCode)
        try container.encode(self.weight, forKey: .weight)
        try container.encode(self.height, forKey: .height)
    }
}

struct Eight: Codable, Hashable {

    let imperial: String
    let metric: String
}

