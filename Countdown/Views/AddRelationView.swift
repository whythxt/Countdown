//
//  AddRelationView.swift
//  Countdown
//
//  Created by Yurii on 01.01.2023.
//

import SwiftUI

struct AddRelationView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var vm: ViewModel

    @State private var name = ""
    @State private var loveName = ""

    @State private var togetherSince = Date.now

    var op: CGFloat {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty  ||
        loveName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?
        -1000 : 0
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                navButtons
                yourNameTF
                loveNameTF
                sinceWhenPicker
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

    var yourNameTF: some View {
        VStack(alignment: .leading) {
            Text("Your name")
                .headerStyle()
                .padding(.top)

            TextField("Write your name", text: $name)
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

    var loveNameTF: some View {
        VStack(alignment: .leading) {
            Text("Your love name")
                .headerStyle()
                .padding(.top)

            TextField("Write your love name", text: $loveName)
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

    var sinceWhenPicker: some View {
        VStack(alignment: .leading) {
            Text("Since when are together?")
                .headerStyle()

            DatePicker("", selection: $togetherSince, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(.graphical)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
                .cornerRadius(10)
        }
    }

    func save() {
        let relation = Relation(
            name: self.name,
            loveName: self.loveName,
            togetherSince: self.togetherSince
        )

        vm.relation = relation

        dismiss()
    }
}

struct AddRelationView_Previews: PreviewProvider {
    static var previews: some View {
        AddRelationView(vm: ViewModel())
    }
}
