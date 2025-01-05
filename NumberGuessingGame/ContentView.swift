//
//  ContentView.swift
//  NumberGuessingGame
//
//  Created by Aidan Bergerson on 12/13/24.
//

import SwiftUI


struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(Color.blue)
    }
}

struct GameButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 150, height: 50)
            .background(.blue)
            .foregroundStyle(.white)
            .font(.subheadline)
            .clipShape(.rect(cornerRadius: 10))

    }
}

extension View {
    func largeBlueTitle() -> some View {
        modifier(LargeBlueTitle())
    }
    
    func gameButton() -> some View {
        modifier(GameButton())
    }
}

struct ContentView: View {
    @State private var guess = 0
    var number = Int.random(in: 1...100)
    @State private var attempts = 0
    @State private var result: String = ""
    @State private var guessArray: [String] = []
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.05)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                
                Spacer()
                
                Text("Guess The Number")
                    .largeBlueTitle()
                
                TextField("Enter a number", value: $guess, format: .number)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.clear)
                            .stroke(Color.black)
                        
                    )
                    .padding(.horizontal, 10)
                
                Button("Submit") {
                    guessNumber()
                }
                .gameButton()
                .padding(.vertical, 10)
                
                
                Spacer()
                Text("Results")
                    .font(.title3).fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(guessArray.reversed(), id: \.self) {
                            Text($0)
                        }
                        .font(.title3)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 400)
                .scrollIndicators(.hidden)
                
            }
        }
    }
    
     func guessNumber() {
         attempts += 1
         
         if number > guess {
             result = "Too Low, pick a higher number!"
         } else if number < guess {
             result = "Too High, pick a lower number!"
         } else {
             result = "Correct! The correct number was \(guess), it took you \(attempts) attempts"
         }
         
         guessArray.append(result)
    }
}

#Preview {
    ContentView()
}
