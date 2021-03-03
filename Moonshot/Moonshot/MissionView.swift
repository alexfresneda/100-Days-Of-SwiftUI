//
//  MissionView.swift
//  Moonshot
//
//  Created by Alejandro Fresneda on 18/12/2020.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let missions: [Mission]
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { geo in
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
//                            .background(Color.red)
                            .frame(width: fullView.size.width, height: geo.frame(in: .global).maxY - fullView.size.height / 4)
                            //                            .padding(.top)
//                            .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 5), axis: (x: 0, y: 1, z: 0))
//                            .scaleEffect(x:)
                    }
                    .frame(height: 320)
//                    .background(Color.blue)
                    
                    
                    
                    Text(self.mission.formatterLaunchDate)
                    
                    Text(self.mission.description)
                        .padding()
                        .layoutPriority(1)
                    HStack {
                        Text("Crew Members")
                            .font(.title)
                            .bold()
                        Spacer()
                    }.padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: self.missions)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                if crewMember.role == "Commander" {
                                    Circle()
                                        .fill(Color.yellow)
                                        .frame(width: 20, height: 20)
                                }
                                
                            }.padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName))
    }
    
    init(mission: Mission, astronauts: [Astronaut], missions: [Mission]) {
        self.mission = mission
        self.missions = missions
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: {$0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
    
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts, missions: missions)
    }
}
