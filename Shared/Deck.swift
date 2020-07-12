//
//  Deck.swift
//  DeckTracker
//
//  Created by David Hodgkinson on 11/07/2020.
//

import Foundation

struct Card: Identifiable {
    public var id : UUID = UUID()
    var name : String
    var count : Int
    
    init(name : String, count : Int = 1) {
        self.name = name
        self.count = count
    }
}

public class Deck : Identifiable, ObservableObject {
    public var id : UUID = UUID()
    @Published var name : String
    @Published var list : [Card] = []
    var listCount : Int = 0
    @Published var sideboard : [Card] = []
    var sideboardCount : Int =  0
    @Published var wins : Int = 0
    @Published var losses : Int = 0
    @Published var draws : Int = 0
    @Published var winPct : Float = 0.0
    
    init(name : String, list: [Card] = [], sideboard: [Card] = []) {
        self.name = name
        self.list = list
        self.sideboard = sideboard
        for card in list {
            listCount += card.count
        }
        for card in sideboard {
            sideboardCount += card.count
        }
    }
    
    func addWin() {
        wins += 1
        calculateWinPct()
    }
    
    func removeWin() {
        if wins > 0 {
            wins -= 1
            calculateWinPct()
        }
    }
    
    func addLoss() {
        losses += 1
        calculateWinPct()
    }
    
    func removeLoss() {
        if losses > 0 {
            losses -= 1
            calculateWinPct()
        }
    }
    
    func addDraw() {
        draws += 1
    }
    
    func removeDraw() {
        if draws > 0 {
            draws -= 1
            calculateWinPct()
        }
    }
    
    func calculateWinPct() {
        let totalGames : Float = Float(wins + losses + draws)
        winPct = Float(wins) / totalGames * 100.0
    }
    
}

let testData = [
    Deck(name: "Jund", list: [
        Card(name: "Tarmogoyf", count: 4),
        Card(name: "Hexdrinker", count: 2),
        Card(name: "Wrenn and Six", count: 3),
        Card(name: "Liliana of the Veil", count: 4),
        Card(name: "Lightning Bolt", count: 4),
        Card(name: "Fatal Push", count: 2),
        Card(name: "Abrupt Decay", count: 1),
        Card(name: "Maelstrom Pulse", count: 1),
        Card(name: "Assassin's Trophy", count: 1),
        Card(name: "Kholagan's Command", count: 2),
        Card(name: "Bloodbraid Elf", count: 3),
        Card(name: "Scavenging Ooze", count: 1),
        Card(name: "Swamp", count: 2),
        Card(name: "Forest", count: 1),
        Card(name: "Blackcleave Cliffs", count: 4),
        Card(name: "Overgrown Tomb", count: 2),
        Card(name: "Blood Crypt", count: 1),
        Card(name: "Stomping Ground", count: 1),
        Card(name: "Bloodstained Mire", count: 4),
        Card(name: "Verdant Catacombs", count: 4),
        Card(name: "Wooded Foothills", count: 2),
        Card(name: "Nurturing Peatland", count: 2),
        Card(name: "Raging Ravine", count: 2),
    ], sideboard: [
        Card(name: "Alpine Moon", count: 2)
    ]),
    Deck(name: "UW Control")
]
