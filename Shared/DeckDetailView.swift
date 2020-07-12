//
//  DeckDetailView.swift
//  DeckTracker
//
//  Created by David Hodgkinson on 11/07/2020.
//

import SwiftUI

struct DeckDetailView : View {
    var deck : Deck
    
    @State var wins : Int = 0
    @State var losses : Int = 0
    @State var draws : Int = 0
    
    init(deck: Deck) {
        self.deck = deck
        self.wins = deck.wins
        self.losses = deck.losses
        self.draws = deck.draws
    }
    
    var body : some View {
        NavigationView {
            VStack {
                Text(String(wins))
                Text(String(draws))
                Text(String(losses))
            }
            .navigationTitle(deck.name)
        }
    }
}

struct DeckDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DeckDetailView(deck: testStore.decks[0])
    }
}
