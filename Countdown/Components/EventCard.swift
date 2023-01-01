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

            Text("\(formatDate()) hours left")
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

    func formatDate() -> Int {
        let diff = Calendar.current.dateComponents([.hour], from: Date.now, to: event.date)

        if let hours = diff.hour {
            return hours
        }

        return 0
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(event: .example)
    }
}
