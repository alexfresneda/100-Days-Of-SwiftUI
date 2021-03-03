//
//  DiceRollView.swift
//  DiceApp
//
//  Created by Alejandro Fresneda on 26/02/2021.
//
import CoreData
import SwiftUI

struct DiceRollView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var numberOfDiceOptions = [1, 2, 3, 4, 5]
    @State private var numberOfDice = 0
    
    @State private var diceRoll = 0
    @State private var diceArray = [Int]()
    
    //add haptic feedback generator
    @State private var feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            ShakableViewRepresentable()
                .allowsHitTesting(false)
            VStack {
                Picker("Number of dice", selection: $numberOfDice) {
                    ForEach(0..<numberOfDiceOptions.count) {
                        Text("\(self.numberOfDiceOptions[$0])")
                    }
                } .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
                
                ForEach(0..<diceArray.count, id:\.self) { roll in
                    Image("\(diceArray[roll])")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                }
                
                
                
                Spacer()
                
                //            Button("Roll dice") {
                //                self.rollDice()
                //            }
                Button(action: {
                    self.rollDice()
                }) {
                    HStack {
                        Spacer()
                        Text("Roll Dice")
                            .bold()
                            .padding(.vertical)
                        
                        Spacer()
                    }.background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }.padding()
            .onReceive(messagePublisher) { _ in
                self.rollDice()
            }
        }
        
    }
    
    func rollDice() {
        //remove previous roll
        diceArray.removeAll()
        
        //roll every dice and add result to diceArray
        for _ in 1...numberOfDiceOptions[numberOfDice] {
            diceRoll = Int.random(in: 1..<7)
            diceArray.append(diceRoll)
        }
        
        self.feedback.notificationOccurred(.success)
        
        //calculate score by adding rolls
        let score = diceArray.reduce(0, +)
        
        //save roll score
        let newRoll = DiceRoll(context: self.moc)
        newRoll.score = Int16(score)
        newRoll.diceNumber = Int16(numberOfDiceOptions[numberOfDice])
        try? self.moc.save()
        
        print(diceArray)
        print(score)
    }
}

struct DiceRollView_Previews: PreviewProvider {
    static var previews: some View {
        DiceRollView()
    }
}
