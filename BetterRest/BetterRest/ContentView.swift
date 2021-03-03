//
//  ContentView.swift
//  BetterRest
//
//  Created by Alejandro Fresneda on 03/12/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    //using a computed property so that the state is updated when the properties above change
    var calculateBedTime: String {
        
        let model = SleepCalculator()

        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        var timeToSleep: String

        do {
            let prediction = try
                model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep

            let formatter = DateFormatter()
            formatter.timeStyle = .short

            timeToSleep = formatter.string(from: sleepTime)


        } catch {
            timeToSleep = "Sorry, there was a problem calculating your bedtime"
        }
        return timeToSleep
    
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                Section (header: Text("Desired amount of sleep")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                Section (header: Text("Daily coffee intake")) {
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            $0 == 1 ? Text("\($0) cup") : Text("\($0) cups")
                        }
                    }//.pickerStyle(WheelPickerStyle())
                }
                Text("Your bedtime is \(calculateBedTime)")
            }
            .navigationBarTitle("BetterRest")
            
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
