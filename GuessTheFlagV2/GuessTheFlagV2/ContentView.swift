//
//  ContentView.swift
//  GuessTheFlagV2
//
//  Created by Alejandro Fresneda on 27/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userAnswer = ""
    @State private var score = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var alertMessage = ""
    
    
    
    var body: some View {
        ZStack {
            
            Color("Background").edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Image(countries[correctAnswer])
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow( color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius: 20)
                    .padding(.bottom, 40)
                
                
                TextField("Enter country name", text: $userAnswer)
                    .padding(10)
                    .background(Color("Textfield"))
                    .cornerRadius(10, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .padding()
                
                Text("Score: \(score)")
               
                Spacer()
                Button (action: {
                    self.forceSkip()
                }) {
                    HStack (spacing: 2) {
                        Text("Skip")
                        
                        Image(systemName: "chevron.right")
                    }
                }
                
                
                Button (action: {
                    self.flagTapped()
                }) {
                    HStack {
                        Spacer()
                        Text("Check my answer")
                            .bold()
                        Spacer()
                    }
                }
                .padding(12)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .padding()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped() {
        if userAnswer == countries[correctAnswer] {
            scoreTitle = "Correct"
            score += 10
            alertMessage = "Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            alertMessage = "Try again! \(countries[correctAnswer].count) letters, \(countries[correctAnswer].first!)..."
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        if scoreTitle == "Correct" {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            userAnswer = ""
        }
    }
    
    func forceSkip() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        userAnswer = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
