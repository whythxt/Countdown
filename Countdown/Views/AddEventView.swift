//
//  AddEventView.swift
//  Countdown
//
//  Created by Yurii on 29.12.2022.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var vm: AddViewModel

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
            .offset(y: vm.op)
        }
    }

    var countdownName: some View {
        VStack(alignment: .leading) {
            Text("Countdown name")
                .headerStyle()
                .padding(.top)

            TextField("Name your countdown", text: $vm.event.name)
                .autocorrectionDisabled()
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

            TextField("", text: $vm.event.emoji)
                .autocorrectionDisabled()
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

            DatePicker("", selection: $vm.event.doe, in: Date()..., displayedComponents: .date)
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

            Toggle("All day", isOn: $vm.event.allDay)
                .togStyle()

            if !vm.event.allDay {
                DatePicker("", selection: $vm.event.doe, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.white)
                    .cornerRadius(10)
            }
        }
    }

    var repeatToggle: some View {
        VStack(alignment: .leading) {
            Text("Repeat")
                .headerStyle()

            Toggle("Repeat yearly", isOn: $vm.event.repeatYearly)
                .togStyle()
        }
    }

    var remindToggles: some View {
        VStack(alignment: .leading) {
            Text("Remind me")
                .headerStyle()

            Toggle("1 day before", isOn: $vm.event.oneDayBefore)
                .togStyle()

            Toggle("1 week before", isOn: $vm.event.oneWeekBefore)
                .togStyle()
        }
    }

    func save() {
        try? vm.save()
        dismiss()
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        let preview = EventsProvider.shared

        AddEventView(vm: .init(provider: preview))
            .environment(\.managedObjectContext, preview.viewContext)
    }
}
