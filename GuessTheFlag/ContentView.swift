//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Diana Dashinevich on 09/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var selectedFlag = 0
    @State private var questionCount = 1
    @State private var showingFinalScore = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.title).bold()
                        .fontDesign(.rounded)
                    
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle).bold()
                        .fontDesign(.rounded)
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                    }
                }
                Text("Your score is \(score)")
                    .foregroundStyle(.white)
                    .font(.title).bold()
                    .fontDesign(.rounded)
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: nextQuestion)
        } message: {
            if selectedFlag != correctAnswer {
                Text("That’s the flag of \(countries[selectedFlag])")
            } else {
                Text("Good job!")
            }
        }
        .alert("Game Over", isPresented: $showingFinalScore) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your final score is \(score) out of 8.")
        }
    }
    
    func flagTapped(_ number: Int) {
        selectedFlag = number
        if selectedFlag == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong!"
        }
        
        if questionCount == 8 {
            showingFinalScore = true
        } else {
            showingScore = true
        }
    }
    
    func nextQuestion() {
        questionCount += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        score = 0
        questionCount = 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
