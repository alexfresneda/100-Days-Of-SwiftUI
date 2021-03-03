//
//  ContentView.swift
//  DiceApp
//
//  Created by Alejandro Fresneda on 26/02/2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        TabView {
            DiceRollView()
                .tabItem {
                    Image(systemName: "shuffle")
                    Text("Table")
                }
            ScoreView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Score")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
