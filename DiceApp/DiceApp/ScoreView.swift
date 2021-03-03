//
//  ScoreView.swift
//  DiceApp
//
//  Created by Alejandro Fresneda on 26/02/2021.
//

import SwiftUI

struct ScoreView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: DiceRoll.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \DiceRoll.score, ascending: false)]) var diceRolls: FetchedResults<DiceRoll>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(diceRolls, id: \.self) { roll in
                    Label("\(roll.score)", systemImage: "\(roll.diceNumber).square.fill")
                }
                .onDelete(perform: deleteRolls)
            }
            .navigationTitle("Scores")
        }
    }
    
    func deleteRolls(at offsets: IndexSet) {
        for offset in offsets {
            let roll = diceRolls[offset]
            moc.delete(roll)
        }
        
        try? moc.save()
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
