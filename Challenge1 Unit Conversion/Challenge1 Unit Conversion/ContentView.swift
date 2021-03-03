//
//  ContentView.swift
//  Challenge1 Unit Conversion - Convert between different temperature units
//
//  Created by Alejandro Fresneda on 25/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkValue = ""
    @State private var inputTemperatureUnit = 0
    @State private var outputTemperatureUnit = 0
    
    let inputValueUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    let outputValueUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var valueInKelvin: Double {
        
        let inputValue = Double(checkValue) ?? 0
        
        switch inputValueUnits[inputTemperatureUnit] {
            case "Celsius":
                return inputValue + 273.15
            case "Fahrenheit":
                return (inputValue - 32) * 5/9 + 273.15
            default:
                return inputValue
        }
    }
    
    var outputValue: Double {
        switch outputValueUnits[outputTemperatureUnit] {
            case "Celsius":
                return valueInKelvin - 273.15
            case "Fahrenheit":
                return (valueInKelvin - 273.15) * 9/5 + 32
            default:
                return valueInKelvin
        }
    }
    
    var body: some View {
        Form {
            Section{
                TextField("Enter value", text: $checkValue)
                    .keyboardType(.decimalPad)
                Picker("Input unit:", selection: $inputTemperatureUnit) {
                    ForEach(0..<inputValueUnits.count) {
                        Text("\(self.inputValueUnits[$0])")
                    }
                } .pickerStyle(SegmentedPickerStyle())
            }
            Section{
                Picker("Output unit:", selection: $outputTemperatureUnit) {
                    ForEach(0..<outputValueUnits.count) {
                        Text("\(self.outputValueUnits[$0])")
                    }
                } .pickerStyle(SegmentedPickerStyle())
                Text("\(outputValue, specifier: "%.2f")")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
