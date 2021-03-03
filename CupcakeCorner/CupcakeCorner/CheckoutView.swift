//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Alejandro Fresneda on 08/01/2021.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation: Bool = false
    @State private var showingError: Bool = false

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.orderInfo.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            
        }
        .alert(isPresented: $showingError) {
            Alert(title: Text("Error"), message: Text("There was an error processing your order"), dismissButton: .default(Text("OK")))
        }
    }
     
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.orderInfo)
        else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https:/reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                self.showingError = true
                return
            }
            if let decodedOrder = try?
                JSONDecoder().decode(OrderInfo.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderInfo.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid reponse from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
