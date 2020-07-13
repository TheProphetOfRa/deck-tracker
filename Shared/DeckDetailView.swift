//
//  DeckDetailView.swift
//  DeckTracker
//
//  Created by David Hodgkinson on 11/07/2020.
//

import SwiftUI

struct DeckDetailView : View {
    @ObservedObject var deck : Deck
    
    var body : some View {
        NavigationView {
            VStack {
                HStack {
                    GameTrackerWidget(deck: deck)
                    VStack {
                        Text("\(deck.winPct, specifier: "%.2f")%")
                            .font(.title)
                    }
                }
                DeckListWidget(deck: deck)
            }
            .padding(.bottom, 10)
            .navigationTitle(deck.name)
            .toolbar {
                #if os(iOS)
                EditButton()
                #endif
            }
        }
    }
}

struct DeckListWidget : View {
    var deck : Deck
    
    var body : some View {
        HStack {
            VStack {
                Text("Mainboard")
                    .foregroundColor(.secondary)
                List {
                    ForEach (deck.list) { card in
                        HStack {
                            Text("\(card.count, specifier: "%dx") ")
                            Text(card.name)
                        }
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
                        HStack {
                            Text("\(card.count, specifier: "%dx") ")
                            Text(card.name)
                        }
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

struct GameTrackerWidget : View {
    var deck : Deck
    
    var body : some View {
        HStack {
            VStack {
                Text("Wins:")
                    .padding(.all, 5)
                Text("Losses:")
                    .padding(.all, 5)
                Text("Draws")
                    .padding(.all, 5)
            }
            VStack {
                Button(action: {
                    deck.removeWin()
                }, label: {
                    Label("", systemImage:"minus.circle")
                })
                .padding(.all, 5)
                Button(action: {
                    deck.removeLoss()
                }, label: {
                    Label("", systemImage:"minus.circle")
                })
                .padding(.all, 5)
                Button(action: {
                    deck.removeDraw()
                }, label: {
                    Label("", systemImage:"minus.circle")
                })
                .padding(.all, 5)
            }
            .foregroundColor(.red)
            VStack {
                Text("\(deck.wins)")
                    .padding(.all, 5)
                Text("\(deck.losses)")
                    .padding(.all, 5)
                Text("\(deck.draws)")
                    .padding(.all, 5)
            }
            VStack {
                Button(action: {
                    deck.addWin()
                }, label: {
                    Label("", systemImage:"plus.circle")
                })
                .padding(.all, 5)
                Button(action: {
                    deck.addLoss()
                }, label: {
                    Label("", systemImage:"plus.circle")
                })
                .padding(.all, 5)
                Button(action: {
                    deck.addDraw()
                }, label: {
                    Label("", systemImage:"plus.circle")
                })
                .padding(.all, 5)
            }
        }
    }
}

struct DeckDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DeckDetailView(deck: testStore.decks[0])
            DeckDetailView(deck: testStore.decks[0])
                .preferredColorScheme(.dark)
        }
    }
}
