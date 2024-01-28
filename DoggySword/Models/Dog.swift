//
//  Dog.swift
//  DoggySword
//
//  Created by Helder Nunes on 26/01/2024.
//

import Foundation

struct Dog: Codable, Hashable, Identifiable {

    let id: String
    let url: URL
    let width: CGFloat?
    let height: CGFloat?

    let breeds: [Breed]
}
