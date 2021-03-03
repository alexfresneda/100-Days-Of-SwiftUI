//
//  ContentView.swift
//  RockPaperScissorsV2
//
//  Created by Alejandro Fresneda on 02/12/2020.
//

import SwiftUI

struct ContentView: View {
    
    var moves = ["✊", "🧻", "✂️", ""]
    @State private var moveChoice = 3
    @State private var playerScore = 0
    @State private var aiScore = 0
    
    @State private var playerChoice = ""
    
    let numberOfGames = [1, 3, 5]
    @State private var gameNumber = 0
    
    var body: some View {
        VStack {
            Picker("Number of games:", selection: $gameNumber) {
                ForEach(0..<numberOfGames.count) {
                    Text("First to \(self.numberOfGames[$0])")
                }
            } .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Spacer()
            
            VStack {
                    VStack {
                        HStack {
                            Text("🤖")
                                .font(.system(size: 50))
                            Text("\(aiScore)")
                        }
                        Text("\(moves[moveChoice])")
                            .font(.system(size: 100))
                            .frame(width: 150, height: 150)
                    }
                    if playerScore < numberOfGames[gameNumber] && aiScore < numberOfGames[gameNumber] {
                        Divider()
                    } else if playerScore > aiScore {
                        Text("You win")
                        Button(action: {
                            self.resetGame()
                        }) {
                            Text("Reset game")
                        }

                    } else {
                        Text("You lose")
                        Button(action: {
                            self.resetGame()
                        }) {
                            Text("Reset game")
                        }
                    }
                    VStack {
                        Text("\(playerChoice)")
                            .font(.system(size: 100))
                            .frame(width: 150, height: 150)
                
                        HStack {
                            Text("🐵")
                                .font(.system(size: 50))
                            Text("\(playerScore)")
                        }
                            
                    }
            }.padding(.horizontal)
            
            Spacer()
            
            HStack {
                Button(action: {
                    self.playerChoice = moves[0]
                    self.newMove()
                    switch moves[moveChoice] {
                        case "✂️":
                            self.playerScore += 1
                        case "🧻":
                            self.aiScore += 1
                        default:
                            self.playerScore += 0
                    }
                }) {
                    Text("✊")
                        .font(.system(size: 60))
                }.padding()
                .background(Color.red)
                .cornerRadius(24, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                Button(action: {
                    self.playerChoice = moves[1]
                    self.newMove()
                    switch moves[moveChoice] {
                        case "✊":
                            self.playerScore += 1
                        case "✂️":
                            self.aiScore += 1
                        default:
                            self.playerScore += 0
                    }
                }) {
                    Text("🧻")
                        .font(.system(size: 60))
                }.padding()
                .background(Color.orange)
                .cornerRadius(24, antialiased: true)
                
                Spacer()
                
                Button(action: {
                    self.playerChoice = moves[2]
                    self.newMove()
                    switch moves[moveChoice] {
                        case "🧻":
                            self.playerScore += 1
                        case "✊":
                            self.aiScore += 1
                        default:
                            self.playerScore += 0
                    }
                }) {
                    Text("✂️")
                        .font(.system(size: 60))
                }.padding()
                .background(Color.yellow)
                .cornerRadius(24, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
            }.padding(.horizontal, 24)
            
            
        }
    }
    
    func newMove() {
        moveChoice = Int.random(in: 0...2)
    }
    func resetGame() {
        aiScore = 0
        playerScore = 0
        moveChoice = 3
        playerChoice = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
