//
//  ContentView.swift
//  WeSplit
//
//  Created by Alejandro Fresneda on 22/11/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    @State private var tipPercentageV2 = ""
    
    let tipPercentages = [10, 15, 20, 25, 0]
    var total: [Double] {
        //calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
//        let tipSelectionV2 = Double(tipPercentageV2) ?? 0
        let orderAmount = Double(checkAmount) ?? 0
        
        //change the line below between tipSelection and tipSelectionV2 to alternate between picker and text field
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return [grandTotal, amountPerPerson, tipSelection]
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people:", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section(header: Text("How much tip do you want to leave?")) {
//                    TextField("Tip percentage", text: $tipPercentageV2)
//                        .keyboardType(.numberPad)
                    Picker("Tip percentage:", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0]) %")
                        }
                    } .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total without tip")) {
                    Text("$\(checkAmount)")
                }
                Section(header: Text("Total including tip")) {
                    Text("$\(total[0], specifier: "%.2f")")
                        .foregroundColor(total[2] == 0 ? .red : .black)
                }
                Section(header: Text("Total per person")) {
                    Text("$\(total[1], specifier: "%.2f")")
                }
            }
        
            .navigationTitle("WeSplit")
        }
       
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
