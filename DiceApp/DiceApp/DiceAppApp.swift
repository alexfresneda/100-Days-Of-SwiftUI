//
//  DiceAppApp.swift
//  DiceApp
//
//  Created by Alejandro Fresneda on 26/02/2021.
//

import SwiftUI

@main
struct DiceAppApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
