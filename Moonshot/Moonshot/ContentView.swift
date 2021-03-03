//
//  ContentView.swift
//  Moonshot
//
//  Created by Alejandro Fresneda on 16/12/2020.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingDates = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts, missions: missions)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        
                        if showingDates {
                            Text(mission.formatterLaunchDate)
                        } else {
                            Text(mission.crewList)
                        }
                    }
                }
            }
            .navigationTitle("Moonshot")
            .navigationBarItems(trailing: Toggle(isOn: $showingDates, label: {
                Text("Dates")
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
