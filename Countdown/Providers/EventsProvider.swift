//
//  EventsProvider.swift
//  Countdown
//
//  Created by Yurii on 08.01.2023.
//

import CoreData
import SwiftUI

final class EventsProvider {
    static let shared = EventsProvider()

    private let persistentContainer: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    var newContext: NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }

    private init() {
        persistentContainer = NSPersistentContainer(name: "Events")

        if EnvironmentValues.isPreview || Thread.current.isRunningXCTest {
            persistentContainer.persistentStoreDescriptions.first?.url = .init(filePath: "/dev/null")
        }

        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to load store: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Data Management

    func exists(_ event: Event, in context: NSManagedObjectContext) -> Event? {
        try? context.existingObject(with: event.objectID) as? Event
    }

    func delete(_ event: Event, in context: NSManagedObjectContext) throws {
        if let existingEvent = exists(event, in: context) {
            context.delete(existingEvent)

            Task(priority: .background) {
                try await context.perform {
                    try context.save()
                }
            }
        }
    }

    func persist(in context: NSManagedObjectContext) throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
