//
//  AstronautView.swift
//  Moonshot
//
//  Created by Alejandro Fresneda on 18/12/2020.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                }
                List(self.missions) { mission in
                    Text(mission.displayName)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name))
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        var matches = [Mission]()
        
        for member in missions {
            if let match = member.crew.first(where: {$0.name == astronaut.id }) {
                matches.append(member)
                
            }
        }
        self.missions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
