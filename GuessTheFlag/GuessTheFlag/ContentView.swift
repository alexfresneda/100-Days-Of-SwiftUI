//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alejandro Fresneda on 26/11/2020.
//

import SwiftUI

struct ContentView: View {
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var animationAmount = 0.0
    @State private var animationOpacity = 1.0
    @State private var shakeFlag = false
    @State private var selectedFlag = 0
    
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 0.9450980392, green: 0.9490196078, blue: 0.9647058824, alpha: 1)).edgesIgnoringSafeArea(.all)
//            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)

            VStack (spacing: 30) {
                Spacer()
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.gray)
                    Text(countries[correctAnswer])
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                Spacer()
                ForEach (0..<3) { number in
                    Button(action: {
//                        withAnimation {
                            self.flagTapped(number)
                            self.selectedFlag = number
//                        }
                    }) {
                        FlagImage(name: self.countries[number])
                    }
                    .offset(x: shakeFlag && number != self.correctAnswer ? -10 : 0)
                    .rotation3DEffect(.degrees(number == self.correctAnswer ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                    .opacity(number != self.correctAnswer ? self.animationOpacity : 1.0)
                    .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown flag"]))
                }
                Spacer()
                Button (action: {
                    self.askQuestion()
                }) {
                    HStack {
                        Spacer()
                        Text("Skip")
                            .bold()
                        Image(systemName: "arrow.right")
                        Spacer()
                    }
                }
                .padding(12)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .padding(24)
            }

        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 10
            withAnimation {
                self.animationAmount = 360
                self.animationOpacity = 0.25
            }
        } else {
            scoreTitle = "Wrong"
            withAnimation(Animation.default.repeatCount(6).speed(4)) {
                self.shakeFlag = true
            }
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        self.animationAmount = 0
        self.animationOpacity = 1
        self.shakeFlag = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagImage: View {
    
    var name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow( color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius: 20)
    }
}
