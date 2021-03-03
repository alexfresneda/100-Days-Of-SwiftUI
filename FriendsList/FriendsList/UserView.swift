//
//  UserView.swift
//  FriendsList
//
//  Created by Alejandro Fresneda on 20/01/2021.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var users = Users()    
    var user: User
    
    
    var body: some View {
        
        Form {
            Section(header: Text("About")) {
                Text("Age: \(user.age)")
                Text("Address: \(user.address)")
                Text("Email: \(user.email)")
                Text("Company: \(user.company)")
            }
            
            Section(header: Text("Tags")) {
                ForEach(user.tags, id: \.self) { tags in
                    Text(tags)
                }
            }
            
            Section(header: Text("Friends")) {
                List(user.friends) { friend in
                        UserListItem(user: self.users.findUser(byName: friend.name)!)
    
                }
            }
            .navigationTitle(user.name)
        }
    }
    //    init(user: User, friends: [User]) {
    //        self.user = user
    //
    //        var matches = [User]()
    //        self.friends = matches
    //
    //        for member in users.items {
    //            if let match = friends.first(where: {$0.name == member.name}) {
    //                matches.append(member)
    //            }
    //        }
    //
    //        self.friends = matches
    //    }
    
}



//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView(users: Users(), user: User(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.", registered: Date(), tags: ["one", "two", "three"], friends: [Friend(id: "", name: "asd"), Friend(id: "", name: "asd")]))
//    }
//}
