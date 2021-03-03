//
//  OrderV2.swift
//  CupcakeCorner
//
//  Created by Alejandro Fresneda on 10/01/2021.
//

import Foundation

class Order: ObservableObject {
    @Published var orderInfo: OrderInfo
    
    init() {
        orderInfo = OrderInfo(type: 0, quantity: 3, specialRequestEnabled: false, extraFrosting: false, addSprinkles: false, name: "", streetAddress: "", city: "", zip: "")
    }
}
    
struct OrderInfo: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
//        init() { }
//
//        required init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//
//            orderInfo = try container.decode(Int.self, forKey: .orderInfo)
//        }
//
//        func encode(to encoder: Encoder) throws {
//            var container = encoder.container(keyedBy: CodingKeys.self)
//
//            try container.encode(orderInfo, forKey: .orderInfo)
//        }
}

