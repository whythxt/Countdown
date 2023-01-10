//
//  EventCard.swift
//  Countdown
//
//  Created by Yurii on 31.12.2022.
//

import SwiftUI
import UserNotifications

struct EventCard: View {
    @Environment(\.managedObjectContext) private var moc

    let provider: EventsProvider
    let timer = Timer.publish(every: 60, tolerance: 0.5, on: .main, in: .common).autoconnect()

    @ObservedObject var event: Event

    var body: some View {
        VStack {
            Text(event.emoji)
                .font(.system(size: 80))
                .frame(height: 120)

            Text(event.name)
                .font(.title2)
                .bold()
                .frame(height: 30)

            Text("\(event.doe.formatted(date: .abbreviated, time: .omitted))")
                .fontWeight(.semibold)

            Text(event.timeLeft)
                .fontWeight(.semibold)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundColor(.secondary.opacity(0.5))
                        .frame(height: 40)
                }
        }
        .onAppear {
            formatDate()
            scheduleNotification()
        }
        .onReceive(timer) { _ in
            if event.timeLeft == "0 minutes left" {
                timer.upstream.connect().cancel()
            } else {
                formatDate()
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 1)
        }
    }

    func formatDate() {
        let dayComp = Calendar.current.dateComponents([.day], from: Date.now, to: event.doe)
        let hourComp = Calendar.current.dateComponents([.hour], from: Date.now, to: event.doe)
        let minComp = Calendar.current.dateComponents([.minute], from: Date.now, to: event.doe)

        guard let days = dayComp.day,
              let hours = hourComp.hour,
              let minutes = minComp.minute
        else { return }

        if days < 2 {
            if hours <= 1 {
                event.timeLeft = "\(minutes) minutes left"
            } else {
                event.timeLeft = "\(hours) hours left"
            }
        } else {
            event.timeLeft = "\(days) days left"
        }
    }

    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()

        let content = UNMutableNotificationContent()
        content.title = event.name
        content.sound = UNNotificationSound.default

        let comps = Calendar.current.dateComponents([.day, .hour, .minute], from: event.doe)

        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        center.add(request)
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        let preview = EventsProvider.shared

        EventCard(provider: preview, event: .preview())
    }
}
