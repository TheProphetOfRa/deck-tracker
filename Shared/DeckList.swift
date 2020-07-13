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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(deckStore.decks) { deck in
                    DeckCell(deck: deck)
                }
                .onMove(perform: moveDeck)
                .onDelete(perform: deleteDeck)
            }
            .navigationTitle("Decks")
            .toolbar {
                #if os(iOS)
                EditButton()
                #endif
                Button(action: {
                    self.showSheetView.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                }
            }
            .sheet (isPresented: $showSheetView, content: {
                AddDeckSheet(isPresented: $showSheetView, deckStore: deckStore)
            })
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

struct AddDeckSheet : View {
    @Binding var isPresented : Bool
    @State private var newDeckName : String = String()
    var deckStore : DeckStore
    @State var mainboard : [Card] = []
    @State var sideboard : [Card] = []
    
    var body : some View {
        VStack {
            HStack{
                Spacer()
                Text("Add Deck")
                    .font(.title)
                Spacer()
            }
            Divider()
            Spacer()
            HStack {
                Text("Deck Name:")
                    .font(.title2)
                Spacer()
                TextField("New Deck", text: $newDeckName)
                    .font(.title2)
            }
            HStack {
                VStack {
                    Text("Mainboard")
                        .foregroundColor(.secondary)
                    List {
                        ForEach (mainboard) { card in
                            Text("\(card.count, specifier: "%d")x \(card.name)")
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                self.mainboard.append(Card(name: "New Card"))
                            })
                            {
                                Label("Add", systemImage: "plus")
                                    .foregroundColor(.accentColor)
                            }
                            Spacer()
                        }
                    }
                }
                VStack {
                    Text("Sideboard")
                        .foregroundColor(.secondary)
                    List {
                        ForEach (sideboard) { card in
                            HStack {
                                
                                Text("\(card.count, specifier: "%d")x \(card.name)")
                            }
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                self.sideboard.append(Card(name: "New Card"))
                            })
                            {
                                Label("Add", systemImage: "plus")
                                    .foregroundColor(.accentColor)
                            }
                            Spacer()
                        }
                    }
                }
            }
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.isPresented = false
                    createDeck()
                })
                {
                    Label("Create", systemImage: "plus")
                        .foregroundColor(.white)
                        .padding()
                }
                .background(Color.green)
                .clipShape(Capsule())
                Spacer()
                Button(action: {
                    self.isPresented = false
                })
                {
                    Label("Cancel", systemImage: "xmark")
                        .foregroundColor(.white)
                        .padding()
                        
                }
                .background(Color.red)
                .clipShape(Capsule())
                Spacer()
            }
        }
        .padding(.all, 10)
    }
    
    func createDeck() {
        withAnimation {
            deckStore.decks.append(Deck(name: newDeckName, list: mainboard, sideboard: sideboard))
        }
    }
}

struct DeckCell: View {
    var deck : Deck
    
    var body: some View {
        NavigationLink(destination: DeckDetailView(deck: deck)) {
            HStack {
                Image("WrennAndSix")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                VStack{
                    HStack {
                        Text(deck.name)
                            .font(.title)
                        Spacer()
                    }
                    HStack {
                        Text("W: \(deck.wins)")
                        Text("L: \(deck.losses)")
                        Text("D: \(deck.draws)")
                        Spacer()
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                Spacer()
                Text("\(deck.winPct, specifier: "%.1f")%")
                Spacer()
            }
            .padding(.trailing, 10)
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
