//
//  DeckTrackerApp.swift
//  Shared
//
//  Created by David Hodgkinson on 10/07/2020.
//

import SwiftUI

@main
struct DeckTrackerApp: App {
    @StateObject private var deckStore = DeckStore()
    
    var body: some Scene {
        WindowGroup {
            DeckList(deckStore: deckStore)
        }
    }
}
