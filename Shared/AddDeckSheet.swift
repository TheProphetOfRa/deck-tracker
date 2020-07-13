//
//  AddDeckSheet.swift
//  DeckTracker
//
//  Created by David Hodgkinson on 13/07/2020.
//

import SwiftUI

struct AddDeckSheet : View {
    @Binding var isPresented : Bool
    var deckStore : DeckStore
    @ObservedObject var deck : Deck = Deck()
    
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
                TextField("New Deck", text: $deck.name)
                    .font(.title2)
            }
            DeckListWidget(deck: deck)
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
            deckStore.decks.append(deck)
        }
    }
}
