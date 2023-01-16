//
//  NotificationsProvider.swift
//  Countdown
//
//  Created by Yurii on 14.01.2023.
//

import Foundation
import UserNotifications

final class NotificationsProvider {
    static let shared = NotificationsProvider()

    // MARK: - Date Formatter

    func formatDate(for event: Event) {
        let cal = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: event.doe) ?? Date.distantFuture

        var current: Date {
            event.allDay ? cal : event.doe
        }

        let dayComp = Calendar.current.dateComponents([.day], from: Date.now, to: current)
        let hourComp = Calendar.current.dateComponents([.hour], from: Date.now, to: current)
        let minComp = Calendar.current.dateComponents([.minute], from: Date.now, to: current)
        let secComp = Calendar.current.dateComponents([.second], from: Date.now, to: current)

        guard let days = dayComp.day,
              let hours = hourComp.hour,
              let minutes = minComp.minute,
              let seconds = secComp.second
        else { return }

        if days < 2 {
            if hours <= 1 {
                if minutes <= 1 {
                    if seconds < 0 {
                        event.timeLeft = "Congrats!"
                    } else {
                        event.timeLeft = "\(seconds) seconds left"
                    }
                } else {
                    event.timeLeft = "\(minutes) minutes left"
                }
            } else {
                event.timeLeft = "\(hours) hours left"
            }
        } else {
            event.timeLeft = "\(days) days left"
        }

        scheduleNotification(for: event)
    }

    // MARK: - Notifications

    func scheduleNotification(for event: Event) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()

        let content = UNMutableNotificationContent()
        content.title = event.name
        content.sound = UNNotificationSound.default

        // Components for user's custom date

        let comps = Calendar.current.dateComponents(
            [.month, .day, .hour, .minute, .second],
            from: event.doe
        )

        // Components if all day

        let cal = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: event.doe) ?? Date.distantFuture

        let allDayComps = Calendar.current.dateComponents(
            [.month, .day, .hour, .minute],
            from: cal
        )

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: event.allDay ? allDayComps : comps,
            repeats: event.repeatYearly
        )

        let request = UNNotificationRequest(
            identifier: event.name,
            content: content,
            trigger: trigger
        )

        center.add(request)
    }

    func removeNotification(for event: Event) {
        let center = UNUserNotificationCenter.current()

        center.getPendingNotificationRequests { notifications in
            for item in notifications {
                if item.identifier.contains(event.name) {
                    center.removePendingNotificationRequests(withIdentifiers: [item.identifier])
                }
            }
        }
    }
}
