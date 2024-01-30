//
//  Routes.swift
//  DoggySword
//
//  Created by Helder Nunes on 26/01/2024.
//

import Foundation

enum Routes {

    static let search = URL(string: "/v1/images/search", relativeTo: URL.base)!
    static let breeds = URL(string: "/v1/breeds/search", relativeTo: URL.base)!
    static let image = URL(string: "/v1/images/", relativeTo: URL.base)!
}
