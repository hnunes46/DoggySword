//
//  Constants.swift
//  DoggySword
//
//  Created by Helder Nunes on 30/01/2024.
//

import Foundation

enum ImageSorting: String, CaseIterable, Identifiable {

    case none
    case ascending
    case descending
    var id: Self { return self }

    var title: String {

        switch self {

        case .none:
                return "No order"

        case .ascending:
                return "Ascending"

        case .descending:
               return "Descending"
        }
    }

    var value: String {

        switch self {

        case .none:
                return "RAND"

        case .ascending:
                return "ASC"

        case .descending:
               return "DESC"
        }
    }
}

enum ErrorMessage: String {

    case network = "Something went wrong!! 😱"
    case localSave = "Something went wrong saving to local storage!! 😱"
    case duplicatedItem = "You already save tha image"
}
