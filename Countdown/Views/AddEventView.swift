//
//  AddEventView.swift
//  Countdown
//
//  Created by Yurii on 29.12.2022.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var emoji = ""

    @State private var date = Date.now
    @State private var time = Date.now

    @State private var allDay = false
    @State private var repeatYearly = false
    @State private var onFinish = false
    @State private var oneDayBefore = false
    @State private var oneWeekBefore = false

    var op: CGFloat {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty  ||
        emoji.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?
        -1000 : 0
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                navButtons
                countdownName
                emojiPicker
                countdownDate
                countdownTime
                repeatToggle
                remindToggles
            }
        }
        .toolbar(.hidden)
        .padding()
        .onTapGesture {
            hideKeyboard()
        }
        .background(Color(UIColor.systemGroupedBackground))
    }

    var navButtons: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .font(.title)
            }

            Spacer()

            Button(action: save) {
                Capsule()
                    .frame(width: 90, height: 45)
                    .overlay {
                        Text("Save")
                            .font(.title3)
                            .foregroundColor(.white)
                            .bold()
                    }
            }
            .offset(y: op)
        }
    }

    var countdownName: some View {
        VStack(alignment: .leading) {
            Text("Countdown name")
                .headerStyle()
                .padding(.top)

            TextField("Name your countdown", text: $name)
                .padding()
                .background {
                    Rectangle()
                        .frame(height: 40)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 1)
        }
    }

    var emojiPicker: some View {
        VStack(alignment: .leading) {
            Text("Pick an emoji")
                .headerStyle()

            TextField("", text: $emoji)
                .frame(width: 50, height: 50)
                .background(RoundedRectangle(cornerRadius: 64).stroke())
                .overlay {
                    Text("+")
                        .font(.title)
                }
                .foregroundColor(.blue)
                .padding(.leading, 1)
        }
    }

    var countdownDate: some View {
        VStack(alignment: .leading) {
            Text("Countdown date")
                .headerStyle()

            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
                .cornerRadius(10)
        }
    }

    var countdownTime: some View {
        VStack(alignment: .leading) {
            Text("Countdown time")
                .headerStyle()

            Toggle("All day", isOn: $allDay)
                .togStyle()

            DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
                .cornerRadius(10)
        }
    }

    var repeatToggle: some View {
        VStack(alignment: .leading) {
            Text("Repeat")
                .headerStyle()

            Toggle("Repeat yearly", isOn: $repeatYearly)
                .togStyle()
        }
    }

    var remindToggles: some View {
        VStack(alignment: .leading) {
            Text("Remind me")
                .headerStyle()

            Toggle("When the countdown finishes", isOn: $onFinish)
                .togStyle()

            Toggle("1 day before", isOn: $oneDayBefore)
                .togStyle()

            Toggle("1 week before", isOn: $oneWeekBefore)
                .togStyle()
        }
    }

    func save() {
        var _ = Event(
            name: self.name,
            emoji: self.emoji,
            date: self.date,
            time: self.time,
            allDay: self.allDay,
            repeatYearly: self.repeatYearly,
            onFinish: self.onFinish,
            oneDayBefore: self.oneDayBefore,
            oneWeekBefore: self.oneWeekBefore
        )

        dismiss()
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
    }
}
