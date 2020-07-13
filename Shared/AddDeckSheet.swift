//
//  AddDeckSheet.swift
//  DeckTracker
//
//  Created by David Hodgkinson on 13/07/2020.
//

import SwiftUI
struct CardCell : View {
    @ObservedObject var card : Card
    
    var body : some View {
        HStack {
            Button(action: {
                card.tryDecreaseCount()
            })
            {
                Image(systemName: "minus")
                    .foregroundColor(.accentColor)
            }
            .buttonStyle(BorderlessButtonStyle())
            Text("\(card.count)x")
            Button(action: {
                card.tryIncreaseCount()
            })
            {
                Image(systemName: "plus")
                    .foregroundColor(.accentColor)
            }
            .buttonStyle(BorderlessButtonStyle())
            Spacer()
            TextField("New Card", text: $card.name)
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
                            CardCell(card: card)
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                self.mainboard.append(Card(name: ""))
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
                            CardCell(card: card)
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
