//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Alejandro Fresneda on 12/12/2020.
//

import SwiftUI


//add styling

struct ContentView: View {
    
    @State private var tables = [false, false, false, false, false, false, false, false, false, false, false, false]
    
    @State private var listOfQuestions = [String]()
    @State private var question = ""
    @State private var listOfResults = [String]()
    @State private var result = ""
    
    @State private var questionCount = 0
    
    @State private var questions = [2, 5, 10]
    @State private var numberOfQuestions = 0
    
    @State private var indices = [Int]()
    @State private var questionPicker = [Int]()
    
    @State private var gameHasStarted = false
    
    @State private var currentQuestion = 0
    
    @State private var answer = ""
    
    @State private var score = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var shwowingAlert = false
    
    var body: some View {
        
        
        NavigationView {
            VStack {
                ScrollView {
                    
                    if !gameHasStarted {
                        HStack {
                            Text("Which tables do you want to practice?".uppercased())
                                .font(.caption)
                                .foregroundColor(Color(UIColor.systemGray2))
                            Spacer()
                        }.padding(.horizontal)
                        .padding(.top)
                        
                        
                        HStack {
                            ForEach (0..<6) { number in
                                Button(action: {
                                    withAnimation {
                                        self.tables[number].toggle()
                                    }
                                }) {
                                    Text("\(number + 1)")
                                }
                                .frame(width: 54, height: 54)
                                .background(tables[number] ? Color.green : Color(UIColor.systemGray3))
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 27))
                            }
                        }.padding(.horizontal)
                        .padding(.vertical, 6)
                        HStack {
                            ForEach (6..<12) { number in
                                Button(action: {
                                    withAnimation {
                                        self.tables[number].toggle()
                                    }
                                }) {
                                    Text("\(number + 1)")
                                }
                                .frame(width: 54, height: 54)
                                .background(tables[number] ? Color.green : Color(UIColor.systemGray3))
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 27))
                            }
                        }
                        
                        
                        HStack {
                            Text("Select number of questions".uppercased())
                                .font(.caption)
                                .foregroundColor(Color(UIColor.systemGray2))
                            Spacer()
                        }.padding(.horizontal)
                        .padding(.top)
                        
                        
                        Picker("Number of questions", selection: $numberOfQuestions) {
                            ForEach(0..<questions.count) {
                                Text("\(self.questions[$0])")
                            }
                        } .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                    }

                    VStack {
                        
                        if !gameHasStarted {
                            Button(action: {
                                self.gameHasStarted = true
                                self.startGame()
                                self.newQuestion()
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Start Game")
                                        .bold()
                                    Spacer()
                                }
                            }
                            .padding()
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .foregroundColor(.white)
                            .padding()
                            
                        } else {
                            Text("How much is \(question)?")
                                .padding(.top)
                            TextField("Enter result", text: $answer)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                                .keyboardType(.numberPad)
                            
                            Spacer()
                            
                            Text("Your score is \(score)")
                            
                            Button(action: {
                                self.checkMyAnswer()
                                self.newQuestion()
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Check My Answer")
                                        .bold()
                                    Spacer()
                                }
                                
                            }
                            .padding()
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .foregroundColor(.white)
                            .padding()
                        }
                    }
                    
                }
                .alert(isPresented: $shwowingAlert) {
                    Alert(title: Text("Well done!"), message: Text("Your score is \(score) out of \(questions[numberOfQuestions])"), dismissButton: .default(Text("Restart")) {
                        self.resetGame()
                    })
                }
            }
            .navigationTitle("MultiTable")
        }
        
    }
    

    
    func startGame() {
        for i in 1...12 {
            if tables[i - 1] {
                for j in 1...12 {
                    listOfQuestions.append("\(i) x \(j)")
                    listOfResults.append("\(i * j)")
                }
            }
        }
        print(tables)
        print(listOfQuestions)
        print(listOfResults)
        
        self.indices = Array(0..<listOfQuestions.count).shuffled()
        for i in 0...questions[numberOfQuestions] {
            questionPicker.append(indices[i])
        }
    }
    
    func newQuestion() {
        
        self.currentQuestion = questionPicker[questionCount]

        self.question = listOfQuestions[currentQuestion]
        self.result = listOfResults[currentQuestion]
                
        if questionCount == questions[numberOfQuestions] {
            self.shwowingAlert = true
        }
        self.questionCount += 1
        self.answer = ""
        
        print(currentQuestion)
    }
    
    func checkMyAnswer() {
        if answer == result {
            self.score += 1
        }
    }
    
    func resetGame() {
       
        self.score = 0
        self.gameHasStarted = false
        self.indices.removeAll()
        self.questionPicker.removeAll()
        self.currentQuestion = 0
        self.questionCount = 0
        
        listOfQuestions.removeAll()
        listOfResults.removeAll()
        
        for i in 0..<tables.count {
            self.tables[i] = false
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
