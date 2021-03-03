//
//  ContentView.swift
//  PeopleList
//
//  Created by Alejandro Fresneda on 06/02/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var people = People()
    @State private var showingAddView = false
    
    var body: some View {
       return NavigationView {
            List {
                ForEach(people.items) { person in
                    NavigationLink(destination: DetailedView(people: people, name: person.name)) {
                        Text(person.name)
                    }
                }
                .onDelete(perform: removeItem)
            }
            .navigationBarTitle("List of People")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddView = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddView) {
                AddView(people: self.people)
            }
        }
        .onAppear(perform: loadData)
        
    }
    
    func removeItem(at offsets: IndexSet) {
        people.items.remove(atOffsets: offsets)
//        self.saveData()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPeople")

        do {
            let data = try Data(contentsOf: filename)
            people = try JSONDecoder().decode(People.self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
