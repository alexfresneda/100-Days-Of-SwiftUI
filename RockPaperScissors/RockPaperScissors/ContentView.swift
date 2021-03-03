//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Alejandro Fresneda on 01/12/2020.
//

import SwiftUI

struct ContentView: View {
    
    var moves = ["Rock", "Paper", "Scissors"]
    @State private var moveChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    
    @State private var numberOfGames = ""
    
    @State private var userChoice = ""
    @State private var userWins = false
    
    @State private var gameCounter = 0
    
    var totalGames: Int {
        Int(numberOfGames) ?? 0
    }
    
    
    var body: some View {
        VStack {
            TextField("Number of games", text: $numberOfGames)
                .keyboardType(.numberPad)
            Text("iPhone plays " + moves[moveChoice])
            if shouldWin {
                Text("You should WIN")
            } else {
                Text("You should LOSE")
            }
            if gameCounter < totalGames {
                Text("\(score)")
            } else {
                VStack {
                    Text("You scored \(score) out of \(totalGames)")
                    Button(action: {
                        self.score = 0
                        self.gameCounter = 0
                    }) {
                        Text("Restart game")
                    }
                }
            }
            
            HStack {
                Button(action: {
                    self.userChoice = moves[0]
                    if moves[moveChoice] == "Scissors" && shouldWin || moves[moveChoice] == "Paper" && !shouldWin {
                        score += 1
                    }
                    self.newMove()
                }) {
                    Text("Rock")
                }
                Button(action: {
                    self.userChoice = moves[1]
                    if moves[moveChoice] == "Rock" && shouldWin || moves[moveChoice] == "Scissors" && !shouldWin {
                        score += 1
                    }
                    self.newMove()
                }) {
                    Text("Paper")
                }
                Button(action: {
                    self.userChoice = moves[2]
                    if moves[moveChoice] == "Paper" && shouldWin || moves[moveChoice] == "Rock" && !shouldWin {
                        score += 1
                    }
                    self.newMove()
                }) {
                    Text("Scissors")
                }
            }
        }
    }
    
    func newMove() {
        moveChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
        gameCounter += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
