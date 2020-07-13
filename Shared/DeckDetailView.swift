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
