//
//  ContentView.swift
//  FriendsList
//
//  Created by Alejandro Fresneda on 20/01/2021.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var users = Users()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users.items) { user in
                    NavigationLink(destination: UserView(users: self.users, user: user)) {
                        UserListItem(user: user)
                    }
                }
            }
            .navigationTitle("FriendFace")
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




