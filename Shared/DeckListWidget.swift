//
//  DeckListWidget.swift
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

struct DeckListWidget : View {
    @ObservedObject var deck : Deck
    
    var body : some View {
        HStack {
            VStack {
                Text("Mainboard")
                    .foregroundColor(.secondary)
                List {
                    ForEach (deck.list) { card in
                        CardCell(card: card)
                    }
                    .onMove(perform: onMoveMainboard)
                    .onDelete(perform: onDeleteMainboard)
                    HStack {
                        Spacer()
                        Button(action: {
                            deck.list.append(Card(name: ""))
                        })
                        {
                            Label("Add", systemImage: "plus")
                                  .foregroundColor(.accentColor)
                        }
                        Spacer()
                    }
                }
                Text("\(deck.listCount) cards")
                    .foregroundColor(.secondary)
            }
            VStack {
                Text("Sideboard:")
                    .foregroundColor(.secondary)
                List {
                    ForEach (deck.sideboard) { card in
                        CardCell(card: card)
                    }
                    .onMove(perform: onMoveSideboard)
                    .onDelete(perform: onDeleteSideboard)
                    Button(action: {
                        deck.sideboard.append(Card(name: ""))
                    })
                    {
                        Label("Add", systemImage: "plus")
                            .foregroundColor(.accentColor)
                    }
                }
                Text("\(deck.sideboardCount) cards")
                    .foregroundColor(.secondary)
            }
        }
    }
    
    func onMoveMainboard(from: IndexSet, to: Int) {
        withAnimation {
            deck.list.move(fromOffsets: from, toOffset: to)
        }
    }
    
    func onMoveSideboard(from: IndexSet, to: Int) {
        withAnimation {
            deck.sideboard.move(fromOffsets: from, toOffset: to)
        }
    }
    
    func onDeleteMainboard(offsets: IndexSet) {
        withAnimation {
            deck.list.remove(atOffsets: offsets)
        }
    }
    
    func onDeleteSideboard(offsets: IndexSet) {
        withAnimation {
            deck.sideboard.remove(atOffsets: offsets)
        }
    }
}
