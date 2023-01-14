//
//  Event.swift
//  Countdown
//
//  Created by Yurii on 31.12.2022.
//

import CoreData
import Foundation

enum Sort {
    case asc, dsc
}

final class Event: NSManagedObject, Identifiable {
    @NSManaged var name: String
    @NSManaged var emoji: String
    @NSManaged var timeLeft: String
    @NSManaged var doe: Date
    @NSManaged var allDay: Bool
    @NSManaged var repeatYearly: Bool
    @NSManaged var oneDayBefore: Bool
    @NSManaged var oneWeekBefore: Bool

    override func awakeFromInsert() {
        super.awakeFromInsert()

        setPrimitiveValue(Date.now, forKey: "doe")
        setPrimitiveValue(false, forKey: "allDay")
        setPrimitiveValue(false, forKey: "repeatYearly")
        setPrimitiveValue(false, forKey: "oneDayBefore")
        setPrimitiveValue(false, forKey: "oneWeekBefore")
    }

    // MARK: - Fetch Request

    private static var contactsFetchRequest: NSFetchRequest<Event> {
        NSFetchRequest(entityName: "Event")
    }

    static func all() -> NSFetchRequest<Event> {
        let request: NSFetchRequest<Event> = contactsFetchRequest

        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Event.name, ascending: true)
        ]

        return request
    }

    // MARK: - Sorting

    static func sort(order: Sort) -> [NSSortDescriptor] {
        [NSSortDescriptor(keyPath: \Event.doe, ascending: order == .asc)]
    }

    // MARK: - Previews

    @discardableResult
    static func makePreview(count: Int, in context: NSManagedObjectContext) -> [Event] {
        var events = [Event]()

        for i in 0 ..< count {
            let event = Event(context: context)
            event.name = "item \(i)"
            event.emoji = "🎂\(i)"
            event.timeLeft = "\(i) hours left"
            event.doe = Calendar.current.date(byAdding: .day, value: i, to: .now) ?? .now
            event.allDay = false
            event.repeatYearly = Bool.random()
            event.oneDayBefore = Bool.random()
            event.oneWeekBefore = Bool.random()

            events.append(event)
        }

        return events
    }

    static func preview(context: NSManagedObjectContext = EventsProvider.shared.viewContext) -> Event {
        makePreview(count: 1, in: context)[0]
    }

    static func empty(context: NSManagedObjectContext = EventsProvider.shared.viewContext) -> Event {
        Event(context: context)
    }
}
