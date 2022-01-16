//
//  Memorize!.swift
//  Memorize!
//
//  Created by Jinho Lee on 1/14/22.
//

import SwiftUI

@main
struct Assignment2App: App {
    
    var body: some Scene {
        let game = EmojiMemoryGame()
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
