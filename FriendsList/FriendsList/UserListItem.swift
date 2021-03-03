//
//  UserListItem.swift
//  FriendsList
//
//  Created by Alejandro Fresneda on 20/01/2021.
//

import SwiftUI

struct UserListItem: View {
    var user: User
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                Text(user.email)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Circle()
                .fill(user.isActive ? Color.green : Color.red.opacity(0))
                .frame(width: 12)
        }
        
    }
}

//struct UserListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListItem()
//    }
//}
