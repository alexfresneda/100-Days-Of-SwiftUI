//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Alejandro Fresneda on 07/01/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderInfo.type) {
                        ForEach(0..<OrderInfo.types.count) {
                            Text(OrderInfo.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.orderInfo.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.orderInfo.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.orderInfo.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.orderInfo.specialRequestEnabled {
                        Toggle(isOn: $order.orderInfo.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.orderInfo.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
