//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Alejandro Fresneda on 08/01/2021.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.orderInfo.name)
                TextField("Street Address", text: $order.orderInfo.streetAddress)
                TextField("City", text: $order.orderInfo.city)
                TextField("Zip", text: $order.orderInfo.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(order.orderInfo.hasValidAddress ==  false)
        }
        .navigationBarTitle("Delivery Address", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
