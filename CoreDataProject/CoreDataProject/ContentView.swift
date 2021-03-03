//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Alejandro Fresneda on 17/01/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Movie.entity(), sortDescriptors: []) var movies: FetchedResults<Movie>
    var body: some View {
        VStack {
            List(movies, id: \.self) { movie in
                Text(movie.title ?? "Unknown")
            }
            
            Button("Add") {
                let movie = Movie(context: self.moc)
                movie.title = "Space Jam"
            }
            
            Button("Save") {
                do {
                    try self.moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
