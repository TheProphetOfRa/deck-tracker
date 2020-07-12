//
//  ContentView.swift
//  Shared
//
//  Created by David Hodgkinson on 10/07/2020.
//

import SwiftUI

struct DeckList: View {
    @ObservedObject var deckStore : DeckStore
    @State private var showSheetView : Bool = false
    @State private var newDeckName : String = String()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(deckStore.decks) { deck in
                    DeckCell(deck: deck)
                }
            }
            .navigationTitle("Decks")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showSheetView.toggle()
            })
            {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
            })
            .sheet (isPresented: $showSheetView)
               {
                NavigationView {
                    HStack {
                        Text("Deck Name:")
                        Spacer()
                        TextField("New Deck", text: $newDeckName)
                    }
                    .navigationBarTitle(Text("Add Deck"), displayMode: .inline)
                    .navigationBarItems(
                        leading: Button(action: {
                            showSheetView = false
                        }) {
                            Image(systemName: "xmark").imageScale(.large)
                        },
                        trailing: Button(action: {
                            createDeck()
                            showSheetView = false;
                        }) {
                            Image(systemName: "plus.circle").imageScale(.large)
                        })
               }
            }
        }
    }
    
    func createDeck() {
        withAnimation {
            deckStore.decks.append(Deck(name: newDeckName))
            newDeckName = ""
        }
    }
    
    func moveDeck(from: IndexSet, to: Int) {
        withAnimation {
            deckStore.decks.move(fromOffsets: from, toOffset: to)
        }
    }
    
    func deleteDeck(offsets: IndexSet) {
        withAnimation {
            deckStore.decks.remove(atOffsets: offsets)
        }
    }
}

struct DeckCell: View {
    var deck : Deck
    
    var body: some View {
        NavigationLink(destination: DeckDetailView(deck: deck)) {
            HStack {
                VStack{
                    HStack {
                        Text(deck.name)
                            .font(.title)
                        Spacer()
                    }
                    HStack {
                        Text("Wins: \(deck.wins)")
                        Text("Losses: \(deck.losses)")
                        Text("Draws: \(deck.draws)")
                        Spacer()
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                Spacer()
                Text("\(deck.winPct, specifier: "%.1f")%")
                Spacer()
            }
            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DeckList(deckStore: testStore)
            DeckList(deckStore: testStore)
                .preferredColorScheme(.dark)
        }
    }
}
