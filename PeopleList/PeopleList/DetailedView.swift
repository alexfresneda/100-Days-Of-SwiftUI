//
//  DetailedView.swift
//  PeopleList
//
//  Created by Alejandro Fresneda on 06/02/2021.
//

import SwiftUI

struct DetailedView: View {
    @ObservedObject var people: People
    @State var name: String
    
    var body: some View {
        Text(name)
    }
}
