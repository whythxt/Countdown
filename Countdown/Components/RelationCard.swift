//
//  RelationCard.swift
//  Countdown
//
//  Created by Yurii on 01.01.2023.
//

import SwiftUI

struct RelationCard: View {
    var relation: Relation

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("hands")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 115, height: 120)

                VStack(alignment: .leading, spacing: 8) {
                    Text("\(relation.name) & \(relation.loveName)")
                        .font(.title2)
                        .bold()

                    Text("YOU HAVE BEEN TOGETHER FOR")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)

                    Text("\(formatDate())")
                        .opacity(0.7)
                        .fontWeight(.semibold)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 50)
                                .foregroundColor(.secondary.opacity(0.5))
                                .frame(height: 40)
                        }
                        .offset(x: -5)
                }
            }

            Text("IN OTHER WORDS")
                .foregroundColor(.secondary)
                .font(.subheadline)
                .padding(.vertical, 5)

            HStack(spacing: 45) {
                Text("10 Months")
                Text("400 Weeks")
                Text("2925 Days")
            }
            .bold()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 3)
        }
    }

    func formatDate() -> String {
        let diff = Calendar.current.dateComponents([.year, .month, .day], from: relation.togetherSince, to: Date.now)

        if let years = diff.year {
            if let days = diff.day {
                return "\(years) years and \(days) days"
            }
        }

        return "0"
    }
}

struct RelationCard_Previews: PreviewProvider {
    static var previews: some View {
        RelationCard(relation: .example)
    }
}
