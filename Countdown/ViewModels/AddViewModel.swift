//
//  AddViewModel.swift
//  Countdown
//
//  Created by Yurii on 08.01.2023.
//

import CoreData
import Foundation

final class AddViewModel: ObservableObject {
    private let provider: EventsProvider
    private let context: NSManagedObjectContext

    @Published var event: Event

    let isNew: Bool

    var op: CGFloat {
        event.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty  ||
        event.emoji.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?
        -1000 : 0
    }

    init(provider: EventsProvider, event: Event? = nil) {
        self.provider = provider
        self.context = provider.newContext

        if let event, let existingContactCopy = provider.exists(event, in: context) {
            self.event = existingContactCopy
            self.isNew = false
        } else {
            self.event = Event(context: self.context)
            self.isNew = true
        }
    }

    func save() throws {
        try provider.persist(in: context)
    }
}
