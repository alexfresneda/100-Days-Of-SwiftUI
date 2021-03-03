//
//  Mission.swift
//  Moonshot
//
//  Created by Alejandro Fresneda on 17/12/2020.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var crewList: String {
        var names = String()
        for i in crew {
            names += i.name + ", "
        }
        names.removeLast(2)
        return names.capitalized
    }
    
    var formatterLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
