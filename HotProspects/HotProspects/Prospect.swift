//
//  Prospect.swift
//  HotProspects
//
//  Created by Alejandro Fresneda on 11/02/2021.
//

import SwiftUI

class Prospect: Identifiable, Codable, Comparable {
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name == rhs.name
    }
    
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name < rhs.name
    }
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    //    static let saveKey = "SavedData"
    
    init() {
        self.people = []
    }
    
    //using User.Defaults -----------------------------------------------------------------------------
    
    //    init() {
    //        //try to decode the data stored in user defaults
    //        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
    //                if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
    //                    self.people = decoded
    //                    return
    //                }
    //            }
    //        //if no data available or can't be decoded, return an empty array
    //        self.people = []
    //    }
    
    //    private func save() {
    //        if let encoded = try? JSONEncoder().encode(people) {
    //            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
    //        }
    //    }
    //-------------------------------------------------------------------------------------------------
    
    //get app's documents' directory
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    //load info from documents' directory - otherwise load empty array of prospects
    func load() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPeople")
        
        do {
            let data = try Data(contentsOf: filename)
            self.people = try JSONDecoder().decode([Prospect].self, from: data)
            return
        } catch {
            print("Unable to load saved data.")
            self.people = []
            return
        }
    }
    
    func sortByName() {
        self.people.sort()
    }
    
    //save info to documents' directory
    func save() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPeople")
            let data = try JSONEncoder().encode(self.people)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
        } catch {
            print("Unable to save data.")
        }
    }
    
    
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
