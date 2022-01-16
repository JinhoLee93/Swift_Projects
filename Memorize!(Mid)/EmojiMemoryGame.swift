//
//  EmojiMemoryGame.swift
//  Assignment2
//  View Model
//
//  Created by Jinho Lee on 1/14/22.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    static private let emojisdict: [String:Array<String>] =
    ["Vehicle": ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐"],
     "Food": ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐"],
     "Face": ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "🥲", "☺️"]]
    
    static private let features = ["Vehicle", "Food", "Face"]
    static private let formal = "Vehicle"
    
    static func createContent() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairs: Int.random(in: 4...emojisdict[formal]!.count), length: emojisdict[formal]!.count)
            { emoji in emojisdict[formal]![emoji] }
    }
    
    @Published var model: MemoryGame<String> = createContent()
    
    func newGame() {
        let randomTheme: String = EmojiMemoryGame.features.randomElement()!
        model.newGame(numberOfPairs:
                        Int.random(in: 4...EmojiMemoryGame.emojisdict[randomTheme]!.count),
                      theme: randomTheme,
                      length: EmojiMemoryGame.emojisdict[randomTheme]!.count)
        {
            emoji in EmojiMemoryGame.emojisdict[randomTheme]![emoji]
        }
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var currentTheme: String {
        model.currentTheme
    }
    
    var score: Int {
        model.score
    }
}
