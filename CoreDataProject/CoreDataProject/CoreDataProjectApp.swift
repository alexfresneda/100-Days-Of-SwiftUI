//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Alejandro Fresneda on 17/01/2021.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
