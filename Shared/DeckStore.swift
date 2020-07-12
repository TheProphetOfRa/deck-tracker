//
//  DeckStore.swift
//  DeckTracker
//
//  Created by David Hodgkinson on 11/07/2020.
//

import Foundation

public class DeckStore : ObservableObject {
    @Published var decks : [Deck]
    
    init(decks: [Deck] = []) {
        self.decks = decks
    }
}

let testStore = DeckStore(decks: testData)
