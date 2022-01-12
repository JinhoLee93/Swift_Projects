//
//  ContentView.swift
//  Memorize
//
//  Created by Jinho Lee on 1/11/22.
//

import SwiftUI

struct ContentView: View {
    let emojisdict: [String:Array<String>] =
        ["Vehicles": ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐"],
         "Food": ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐"],
         "Faces": ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "🥲", "☺️"]]
    @State var feature: String = "Vehicles"
    @State var shuffle: Bool = false

    var body: some View {
        VStack {
            // Top
            Text("Memorize!")
                .font(.largeTitle)
            Spacer()
            // End of Top
            
            // Middle
            ScrollView {
                let emojis: Array<String>? = emojisdict[feature]!
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(shuffle ? emojis!.shuffled() : emojis!, id: \.self, content: { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    })
                }
            }
            // End of Middle
            
            // Bottom
            HStack {
                Vehicles
                Spacer()
                Food
                Spacer()
                Faces
            }
            .padding(.horizontal)
            .foregroundColor(.blue)
        }
        .padding(.horizontal)
        // End of Bottom
    }
    
    var Vehicles: some View {
        VStack {
            Image(systemName: "car")
                .resizable()
                .frame(width: 32, height: 32)
            Text("Vehicles")
                .font(.system(size: 10))
        }
        .padding()
        .onTapGesture {
            if feature != "Vehicles" {
                feature = "Vehicles"
            } else {
                shuffle.toggle()
            }
        }
    }
    
    var Food: some View {
        VStack {
            Image(systemName: "fork.knife")
                .resizable()
                .frame(width: 30, height: 30)
            Text("Food")
                .font(.system(size: 10))
        }
        .padding()
        .onTapGesture {
            if feature != "Food" {
                feature = "Food"
            } else {
                shuffle.toggle()
            }
        }
    }
    
    var Faces: some View {
        VStack {
            Image(systemName: "person")
                .resizable()
                .frame(width: 30, height: 30)
            Text("Faces")
                .font(.system(size: 10))
        }
        .padding()
        .onTapGesture {
            if feature != "Faces" {
                feature = "Faces"
            } else {
                shuffle.toggle()
            }
        }
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else{
                shape.fill()
            }
        }
        .foregroundColor(.red)
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        
        ContentView()
            .preferredColorScheme(.light)
            
    }
}
