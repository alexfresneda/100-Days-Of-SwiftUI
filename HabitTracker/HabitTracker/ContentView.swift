//
//  ContentView.swift
//  HabitTracker
//
//  Created by Alejandro Fresneda on 05/01/2021.
//

import SwiftUI

struct Habit: Identifiable, Codable {
    let id = UUID()
    let title: String
    let icon: String
    let description: String
    var habitCount: Int
}

class Habits: ObservableObject {
    @Published var items = [Habit]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try?
                encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Habit].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var habits = Habits()
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { item in
                    NavigationLink(destination: HabitView(habits: habits, title: item.title, icon: item.icon, description: item.description, habitCount: item.habitCount, id: item.id)) {
                        HStack {
                            Text(item.icon)
                            Text(item.title)
                            Spacer()
                            Text("\(item.habitCount)")
                        }
                    }
                }
                .onDelete(perform: removeItem)
            }
            .navigationBarTitle("Habits")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddHabit = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddHabit) {
                AddView(habits: self.habits)
            }
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
