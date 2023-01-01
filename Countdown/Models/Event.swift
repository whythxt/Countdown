//
//  Event.swift
//  Countdown
//
//  Created by Yurii on 31.12.2022.
//

import Foundation

struct Event {
    var name: String
    var emoji: String
    var date: Date
    var time: Date
    var allDay: Bool
    var repeatYearly: Bool
    var onFinish: Bool
    var oneDayBefore: Bool
    var oneWeekBefore: Bool

    static let example = Event(
        name: "My Birthday",
        emoji: "🎂",
        date: Date(timeIntervalSinceNow: 86400),
        time: Date.distantFuture,
        allDay: false,
        repeatYearly: false,
        onFinish: false,
        oneDayBefore: false,
        oneWeekBefore: false
    )
}
