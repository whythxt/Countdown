//
//  Relation.swift
//  Countdown
//
//  Created by Yurii on 01.01.2023.
//

import Foundation

struct Relation: Codable {
    var name: String
    var loveName: String
    var togetherSince: Date

    static let example = Relation(
        name: "Adam",
        loveName: "Eve",
        togetherSince: Date.distantPast
    )
}
