//
//  HabitView.swift
//  HabitTracker
//
//  Created by Alejandro Fresneda on 05/01/2021.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var habits: Habits
    
    @State var title: String
    @State var icon: String
    @State var description: String
    @State var habitCount: Int
    @State var id: UUID
    
    var body: some View {
        ScrollView {
            VStack {
                Button("Done today") {
//                    self.habitCount += 1
                    for member in habits.items {
                        if member.id == id {
//                            member.habitCount = self.habitCount
                            print(member.title)
                            
                        }
                    }
                }
                Text("\(habitCount)")
                Text(description)
            }
        }.navigationTitle("\(icon) \(title)")
    }
}

//struct HabitView_Previews: PreviewProvider {
//    static var previews: some View {
//        HabitView(title: title, icon: icon, description: description)
//    }
//}
