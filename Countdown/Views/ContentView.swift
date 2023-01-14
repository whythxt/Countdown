//
//  ContentView.swift
//  Countdown
//
//  Created by Yurii on 28.12.2022.
//

import SwiftUI

struct ContentView: View {
    var provider = EventsProvider.shared

    @StateObject var rp = RelationProvider()

    @FetchRequest(fetchRequest: Event.all()) private var events

    @State private var eventToEdit: Event?
    @State private var sort = Sort.asc

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
            .sheet(item: $eventToEdit) {
                eventToEdit = nil
            } content: { event in
                AddEventView(vm: .init(provider: provider, event: event))
            }
            .sheet(isPresented: $showingRelationSheet) {
                AddRelationView(rp: rp)
            }
            .onChange(of: sort) { newSort in
                events.nsSortDescriptors = Event.sort(order: newSort)
            }
            .onAppear {
                UNUserNotificationCenter.current()
                    .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        // All set
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
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
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ 
                                            try? provider.delete(event, in: provider.viewContext)
                                        }
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

            if rp.relation == nil {
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
                RelationCard(relation: rp.relation!)
                    .padding(1)
                    .padding(.top, 9)
                    .contextMenu {
                        Button("Delete", role: .destructive) {
                            rp.delete()
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
    }

    func toggleRelation() {
        showingRelationSheet.toggle()
    }

    func toggleSort() {
        if sort == .asc {
            sort = .dsc
        } else {
            sort = .asc
        }
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
