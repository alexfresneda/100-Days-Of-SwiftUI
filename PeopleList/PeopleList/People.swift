//
//  People.swift
//  PeopleList
//
//  Created by Alejandro Fresneda on 06/02/2021.
//

import Foundation

struct Person: Identifiable, Codable {
    let id = UUID()
    let name: String
}

class People: ObservableObject, Codable {
    var items = [Person]()
}

//-----------using UserDefaults

//class People: ObservableObject {
//    @Published var items = [Person]() {
//        didSet {
//            let encoder = JSONEncoder()
//
//            if let encoded = try?
//                encoder.encode(items) {
//                UserDefaults.standard.set(encoded, forKey: "Items")
//            }
//        }
//    }
//
//    init() {
//        if let items = UserDefaults.standard.data(forKey: "Items") {
//            let decoder = JSONDecoder()
//
//            if let decoded = try? decoder.decode([Person].self, from: items) {
//                self.items = decoded
//                return
//            }
//        }
//        self.items = []
//    }
//}
