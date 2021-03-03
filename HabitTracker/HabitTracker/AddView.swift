//
//  AddView.swift
//  HabitTracker
//
//  Created by Alejandro Fresneda on 05/01/2021.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habits: Habits
    @State private var title = ""
    @State private var icon = ""
    @State private var description = ""
    @State private var habitCount = 0
//    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $title)
                TextField("Icon", text: $icon)
                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing:
                Button("Save") {
                    var item = Habit(title: self.title, icon: self.icon, description: self.description, habitCount: self.habitCount)
                    self.habits.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                    
//                    else {
//                        self.showingAlert = true
//                    }
            })
//            .alert(isPresented: $showingAlert) { Alert(title: Text("Invalid value"), message: Text("Make sure the amount is a numeric value"), dismissButton: .default(Text("OK")))
//            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
