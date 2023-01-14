//
//  CountdownTests.swift
//  CountdownTests
//
//  Created by Yurii on 14.01.2023.
//

import XCTest
@testable import Countdown

final class CountdownTests: XCTestCase {
    private var provider: EventsProvider!

    override func setUp() {
        provider = .shared
    }

    override func tearDown() {
        provider = nil
    }

    func testEventIsEmpty() {
        let event = Event.empty(context: provider.viewContext)

        XCTAssertEqual(event.name, "")
        XCTAssertEqual(event.emoji, "")
        XCTAssertEqual(event.timeLeft, "")
        XCTAssertTrue(Calendar.current.isDateInToday(event.doe))
        XCTAssertEqual(event.allDay, false)
        XCTAssertEqual(event.repeatYearly, false)
        XCTAssertEqual(event.oneDayBefore, false)
        XCTAssertEqual(event.oneWeekBefore, false)
    }

    func testMakeEventsPreviewIsValid() {
        let count = 5
        let events = Event.makePreview(count: count, in: provider.viewContext)

        for i in 0 ..< events.count {
            let item = events[i]

            XCTAssertEqual(item.name, "item \(i)")
            XCTAssertEqual(item.emoji, "🎂\(i)")
            XCTAssertEqual(item.timeLeft, "\(i) hours left")
            XCTAssertNotNil(item.allDay)
            XCTAssertNotNil(item.repeatYearly)
            XCTAssertNotNil(item.oneDayBefore)
            XCTAssertNotNil(item.oneWeekBefore)

            let dateToCompare = Calendar.current.date(byAdding: .day, value: i, to: .now)
            let doeDay = Calendar.current.dateComponents([.day], from: item.doe, to: dateToCompare!).day

            XCTAssertEqual(doeDay, 0)
        }

    }
}
