//
//  RelationCard.swift
//  Countdown
//
//  Created by Yurii on 01.01.2023.
//

import SwiftUI

enum DateComp {
    case months, weeks, days, both
}

struct RelationCard: View {
    let relation: Relation

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("hands")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 110)
                    .offset(x: -15)

                VStack(alignment: .leading, spacing: 8) {
                    Text("\(relation.name) & \(relation.loveName)")
                        .font(.title2)
                        .bold()

                    Text("YOU HAVE BEEN TOGETHER FOR")
                        .font(.footnote)
                        .foregroundColor(.secondary)

                    Text("\(formatDate(.both))")
                        .opacity(0.6)
                        .fontWeight(.semibold)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 50)
                                .foregroundColor(.secondary.opacity(0.5))
                                .frame(height: 40)
                        }
                        .offset(x: -5)
                }
                .offset(x: -15)
            }

            Text("IN OTHER WORDS")
                .foregroundColor(.secondary)
                .font(.subheadline)
                .padding(.vertical, 5)

            HStack {
                Text(formatDate(.months))
                Spacer()
                Text(formatDate(.weeks))
                Spacer()
                Text(formatDate(.days))
            }
            .bold()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 1)
        }
    }

    func formatDate(_ str: DateComp) -> String {
        let togetherFor = Calendar.current.dateComponents(
            [.year, .day],
            from: relation.togetherSince,
            to: Date.now)

        let monthsComp = Calendar.current.dateComponents(
            [.month],
            from: relation.togetherSince,
            to: Date.now)

        let weeksComp = Calendar.current.dateComponents(
            [.weekOfMonth],
            from: relation.togetherSince,
            to: Date.now)

        let daysComp = Calendar.current.dateComponents(
            [.day],
            from: relation.togetherSince,
            to: Date.now)


        guard let years = togetherFor.year,
              let day = togetherFor.day,
              let months = monthsComp.month,
              let weeks = weeksComp.weekOfMonth,
              let days = daysComp.day
        else { return "0" }

        switch str {
            case .months: return "\(months) months"
            case .weeks: return "\(weeks) weeks"
            case .days: return "\(days) days"
            case .both: if years == 0 {
                return "\(day) days"
            } else {
                return "\(years) years and \(day) days"
            }
        }
    }
}

struct RelationCard_Previews: PreviewProvider {
    static var previews: some View {
        RelationCard(relation: .example)
    }
}
