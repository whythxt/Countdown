//
//  EventCard.swift
//  Countdown
//
//  Created by Yurii on 31.12.2022.
//

import SwiftUI

struct EventCard: View {
    let event: Event

    var body: some View {
        VStack {
            Text(event.emoji)
                .font(.system(size: 80))
                .frame(height: 120)

            Text(event.name)
                .font(.title2)
                .bold()
                .frame(height: 30)

            Text("\(event.date.formatted(date: .abbreviated, time: .omitted))")
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
                .shadow(radius: 3)
        }
    }

    func formatDate() -> String {
        let dayComp = Calendar.current.dateComponents([.day], from: Date.now, to: event.date)
        let hourComp = Calendar.current.dateComponents([.hour], from: Date.now, to: event.date)

        guard let days = dayComp.day, let hours = hourComp.hour else { return "" }

        if days < 2 {
            return "\(hours) hours left"
        } else {
            return "\(days) days left"
        }
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(event: .example)
    }
}
