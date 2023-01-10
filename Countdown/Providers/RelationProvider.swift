//
//  RelationProvider.swift
//  Countdown
//
//  Created by Yurii on 10.01.2023.
//

import Foundation

class RelationProvider: ObservableObject {
    @Published var relation: Relation?

    let saveKey = "Relation"

    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Relation.self, from: data) {
                relation = decoded
                return
            }
        }

        relation = nil
    }

    func delete() {
        relation = nil
        save()
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(relation) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
}
