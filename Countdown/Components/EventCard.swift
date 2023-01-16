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

    let notifier = NotificationsProvider.shared
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
            if event.timeLeft == "Congrats!" {
                timer.upstream.connect().cancel()
            } else {
                notifier.formatDate(for: event)
            }
        }
        .onChange(of: event.doe) { _ in
            notifier.formatDate(for: event)
        }
        .onChange(of: event.allDay) { _ in
            notifier.formatDate(for: event)
        }
        .onReceive(timer) { _ in
            if event.timeLeft == "Congrats!" {
                timer.upstream.connect().cancel()
            } else {
                notifier.formatDate(for: event)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 1)
        }
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        let preview = EventsProvider.shared

        EventCard(provider: preview, event: .preview())
    }
}
