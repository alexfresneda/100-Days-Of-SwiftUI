////
////  Order.swift
////  CupcakeCorner
////
////  Created by Alejandro Fresneda on 08/01/2021.
////
//
//import Foundation
//
//class Order: ObservableObject, Codable {
//    // We cannot use COdable with classes that have @Published properties.
//    
//    // Therefore, the first step means adding an enum that conforms to CodingKey, listing all the properties we want to save.
//    enum CodingKeys: CodingKey {
//        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
//    }
//    
//    //The second step requires us to write an encode(to:) method that creates a container using the coding keys enum we just created, then writes out all the properties attached to their respective key. SEE FUN ENCODE BELOW
//    
//    
//    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
//    
//    @Published var type = 0
//    @Published var quantity = 3
//    
//    @Published var specialRequestEnabled = false {
//        didSet {
//            if specialRequestEnabled == false {
//                extraFrosting = false
//                addSprinkles = false
//            }
//        }
//    }
//    
//    @Published var extraFrosting = false
//    @Published var addSprinkles = false
//    
//    @Published var name = ""
//    @Published var streetAddress = ""
//    @Published var city = ""
//    @Published var zip = ""
//    
//    var hasValidAddress: Bool {
//        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
//            return false
//        }
//        
//        return true
//    }
//    
//    var cost: Double {
//        var cost = Double(quantity) * 2
//        cost += Double(type) / 2
//        
//        if extraFrosting {
//            cost += Double(quantity)
//        }
//        
//        if addSprinkles {
//            cost += Double(quantity) / 2
//        }
//        
//        return cost
//    }
//    
//    init() { }
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//        
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//        
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
//    }
//}
