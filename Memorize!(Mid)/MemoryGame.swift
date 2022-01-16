//
//  MemoryGame.swift
//  Assignment2
//  Model
//
//  Created by Jinho Lee on 1/14/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var indexOfFirstCard: Int?
    private(set) var currentTheme = "Vehicle"
    private(set) var score = 0
    private var randomSet: Set<Int>
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatch = indexOfFirstCard {
                if cards[chosenIndex].content == cards[potentialMatch].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatch].isMatched = true
                    score += 2
                }
                else {
                    // Penalty schematics
                    if cards[chosenIndex].seen && cards[potentialMatch].seen {
                        score -= 2
                    } else if cards[potentialMatch].seen {
                        score -= 1
                    } else if cards[chosenIndex].seen {
                        score -= 1
                    }
                    
                    if !cards[potentialMatch].seen {
                        cards[potentialMatch].seen.toggle()
                    }
                }
                
                if !cards[chosenIndex].seen {
                    cards[chosenIndex].seen.toggle()
                }
                
                indexOfFirstCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfFirstCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    mutating func newGame(numberOfPairs: Int, theme: String, length: Int, createNew: (Int) -> CardContent) {
        var randomIndex: Int
        cards = Array<Card>()
        randomSet = Set<Int>()
        currentTheme = theme
        score = 0
        
        for index in 0..<numberOfPairs {
            randomIndex = Int.random(in: 0..<length)
            if randomSet.contains(randomIndex) {
                while randomSet.contains(randomIndex) {
                    randomIndex = Int.random(in: 0..<length)
                }
            }
            
            let content = createNew(randomIndex)
            cards.append(Card(content: content, id: index * 2))
            cards.append(Card(content: content, id: index * 2 + 1))
        }
        
        cards.shuffle()
    }
    
    init (numberOfPairs: Int, length: Int, createContent: (Int) -> CardContent) {
        var randomIndex: Int
        cards = Array<Card>()
        randomSet = Set<Int>()
        
        for index in 0..<numberOfPairs {
            randomIndex = Int.random(in: 0..<length)
            if randomSet.contains(randomIndex) {
                while randomSet.contains(randomIndex) {
                    randomIndex = Int.random(in: 0..<length)
                }
            }
            
            randomSet.insert(randomIndex)
            
            let content = createContent(randomIndex)
            cards.append(Card(content: content, id: index * 2))
            cards.append(Card(content: content, id: index * 2 + 1))
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var seen = false
        let content: CardContent
        let id: Int
    }
}
