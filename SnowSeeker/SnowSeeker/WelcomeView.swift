//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Alejandro Fresneda on 28/02/2021.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
