//
//  EventCard.swift
//  Countdown
//
//  Created by Yurii on 31.12.2022.
//

import SwiftUI

struct EventCard: View {
    @Environment(\.managedObjectContext) private var moc

    let provider: EventsProvider

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

            Text(formatDate())
                .fontWeight(.semibold)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundColor(.secondary.opacity(0.5))
                        .frame(height: 40)
                }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 1)
        }
    }

    func formatDate() -> String {
        let dayComp = Calendar.current.dateComponents([.day], from: Date.now, to: event.doe)
        let hourComp = Calendar.current.dateComponents([.hour], from: Date.now, to: event.doe)
        let minComp = Calendar.current.dateComponents([.minute], from: Date.now, to: event.doe)

        guard let days = dayComp.day,
              let hours = hourComp.hour,
              let minutes = minComp.minute
        else { return "" }

        if days < 2 {
            if hours <= 1 {
                return "\(minutes) minutes left"
            } else {
                return "\(hours) hours left"
            }
        } else {
            return "\(days) days left"
        }
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        let preview = EventsProvider.shared

        EventCard(provider: preview, event: .preview())
    }
}
