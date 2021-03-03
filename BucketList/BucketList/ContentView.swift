//
//  ContentView.swift
//  BucketList
//
//  Created by Alejandro Fresneda on 02/02/2021.
//

import LocalAuthentication
import SwiftUI

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var showingAuthError = false
    
    var body: some View {
        if isUnlocked {
            UnlockedView()
        } else {
            Button("Unlock Places") {
                self.authenticate()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .alert(isPresented: $showingAuthError) {
                Alert(title: Text("Authentication Error"), message: Text("You are not authorised to log in to the app"), dismissButton: .default(Text("OK")))
        }
    }
    
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authnticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.showingAuthError = true
                    }
                }
            }
        } else {
            //no biometrics
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
