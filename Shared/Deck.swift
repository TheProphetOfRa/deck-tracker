//
//  Deck.swift
//  DeckTracker
//
//  Created by David Hodgkinson on 11/07/2020.
//

import Foundation

struct Card {
    var name : String
    var count : Int
    
    init(name : String, count : Int = 1) {
        self.name = name
        self.count = count
    }
}

public class Deck : Identifiable {
    public var id : UUID = UUID()
    var name : String
    var list : [Card] = []
    var wins : Int = 0
    var losses : Int = 0
    var draws : Int = 0
    var totalGames : Int = 0
    var winPct : Float = 0.0
    
    init(name : String) {
        self.name = name
    }
    
    func addWin() {
        wins += 1
        totalGames += 1
        calculateWinPct()
    }
    
    func removeWin() {
        if wins > 0 {
            wins -= 1
            totalGames -=  1
            calculateWinPct()
        }
    }
    
    func addLoss() {
        losses += 1
        totalGames += 1
        calculateWinPct()
    }
    
    func removeLoss() {
        if losses > 0 {
            losses -= 1
            totalGames -= 1
            calculateWinPct()
        }
    }
    
    func addDraw() {
        draws += 1
        totalGames += 1
    }
    
    func removeDraw() {
        if draws > 0 {
            draws -= 1
            totalGames -= 1
            calculateWinPct()
        }
    }
    
    func calculateWinPct() {
        winPct = (Float)(wins / totalGames)
    }
    
}

let testData = [
    Deck(name: "Jund"),
    Deck(name: "UW Control")
]
