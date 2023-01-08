//
//  ContentView.swift
//  Countdown
//
//  Created by Yurii on 28.12.2022.
//

import SwiftUI

struct ContentView: View {
    var provider = EventsProvider.shared

    @FetchRequest(fetchRequest: Event.all()) private var events

    @State private var eventToEdit: Event?
    @State private var sort = Sort.asc

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
            .sheet(item: $eventToEdit) {
                eventToEdit = nil
            } content: { event in
                AddEventView(vm: .init(provider: provider, event: event))
            }
            .onChange(of: sort) { newSort in
                events.nsSortDescriptors = Event.sort(order: newSort)
            }
        }
    }

    var navButtons: some View {
        HStack(spacing: 20) {
            Button(action: toggleSort) {
                Image(systemName: sort == .asc ? "arrow.up" : "arrow.down")

            }
            .buttonStyle(PrimaryButtonStyle())

            Spacer()

            Button {
                eventToEdit = .empty(context: provider.newContext)
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(PrimaryButtonStyle())
        }
    }

    var eventsCount: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Events")
                .font(.title)
                .bold()

            Text("Countdowns")
                .font(.title)

            if events.isEmpty {
                Button {
                    eventToEdit = .empty(context: provider.newContext)
                } label: {
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
                        ForEach(events) { event in
                            EventCard(provider: provider, event: event)
                                .padding(1)
                                .contextMenu {
                                    Button("Edit") {
                                        eventToEdit = event
                                    }

                                    Button("Delete", role: .destructive) {
                                        try? provider.delete(event, in: provider.viewContext)
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

            Button(action: someStuff) {
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

            //            if vm.relation == nil {
            //                Button(action: toggleRelation) {
            //                    Image(systemName: "plus")
            //                        .font(.title2)
            //                        .padding(15)
            //                        .background(.regularMaterial)
            //                        .cornerRadius(50)
            //                        .frame(maxWidth: .infinity, minHeight: 200)
            //                        .background {
            //                            Rectangle()
            //                                .foregroundColor(.gray.opacity(0.05))
            //                                .cornerRadius(10)
            //                        }
            //                }
            //                .padding(.top, 10)
            //            } else {
            //                RelationCard(relation: vm.relation!)
            //                    .padding(1)
            //                    .padding(.top, 9)
            //                    .contextMenu {
            //                        Button("Edit") {
            //                            vm.editRelation()
            //                        }
            //
            //                        Button("Delete", role: .destructive) {
            //                            vm.deleteRelation()
            //                        }
            //                    }
            //
            //            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
    }

    func toggleSort() {
        if sort == .asc {
            sort = .dsc
        } else {
            sort = .asc
        }
    }

    func someStuff() {

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let preview = EventsProvider.shared
        let emptyPreview = EventsProvider.shared

        ContentView(provider: preview)
            .environment(\.managedObjectContext, preview.viewContext)
            .previewDisplayName("Events With Data")
            .onAppear {
                Event.makePreview(count: 10, in: preview.viewContext)
            }

        ContentView(provider: preview)
            .environment(\.managedObjectContext, emptyPreview.viewContext)
            .previewDisplayName("Events With No Data")
    }
}
