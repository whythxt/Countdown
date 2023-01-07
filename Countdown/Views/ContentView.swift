//
//  ContentView.swift
//  Countdown
//
//  Created by Yurii on 28.12.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()

    @State private var showingEventSheet = false
    @State private var showingRelationSheet = false

    var eventsRows: [GridItem] {
        [GridItem(.adaptive(minimum: 250))]
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                navButtons
                eventsCount
                relationshipCount
            }
            .padding()
            .toolbar(.hidden)
            .fullScreenCover(isPresented: $showingEventSheet) {
                AddEventView(vm: vm)
            }
            .fullScreenCover(isPresented: $showingRelationSheet) {
                AddRelationView(vm: vm)
            }
        }
    }

    var navButtons: some View {
        HStack(spacing: 20) {
            Button(action: toggleEvent) { Image(systemName: "arrow.up.arrow.down.square") }
                .buttonStyle(PrimaryButtonStyle())

            Button(action: someStuff) { Image(systemName: "square.and.pencil") }
                .buttonStyle(PrimaryButtonStyle())

            Button {
                showingEventSheet.toggle()
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(PrimaryButtonStyle())

            Spacer()
        }
    }

    var eventsCount: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Events")
                .font(.title)
                .bold()

            Text("Countdowns")
                .font(.title)

            if vm.events.isEmpty {
                Button(action: toggleEvent) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .padding(15)
                        .background(.regularMaterial)
                        .cornerRadius(50)
                        .frame(width: 150, height: 250)
                        .background {
                            Rectangle()
                                .foregroundColor(.gray.opacity(0.05))
                                .cornerRadius(10)
                        }
                }
                .padding(.top, 10)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: eventsRows, spacing: 20) {
                        ForEach(vm.events) { event in
                            EventCard(event: event)
                                .padding(1)
                                .contextMenu {
                                    Button("Edit") {
                                        vm.editEvent()
                                    }

                                    Button("Delete", role: .destructive) {
                                        vm.deleteEvent()
                                    }
                                }
                        }
                    }
                }
                .padding(.top, 10)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
    }

    var relationshipCount: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Relationship")
                .font(.title)
                .bold()

            Text("Counter")
                .font(.title)

            if vm.relation == nil {
                Button(action: toggleRelation) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .padding(15)
                        .background(.regularMaterial)
                        .cornerRadius(50)
                        .frame(maxWidth: .infinity, minHeight: 200)
                        .background {
                            Rectangle()
                                .foregroundColor(.gray.opacity(0.05))
                                .cornerRadius(10)
                        }
                }
                .padding(.top, 10)
            } else {
                RelationCard(relation: vm.relation!)
                    .padding(1)
                    .padding(.top, 9)
                    .contextMenu {
                        Button("Edit") {
                            vm.editRelation()
                        }

                        Button("Delete", role: .destructive) {
                            vm.deleteRelation()
                        }
                    }

            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
    }

    func toggleEvent() {
        showingEventSheet.toggle()
    }

    func toggleRelation() {
        showingRelationSheet.toggle()
    }

    func someStuff() {

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
    }
}
