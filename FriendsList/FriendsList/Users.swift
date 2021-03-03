//
//  Users.swift
//  FriendsList
//
//  Created by Alejandro Fresneda on 20/01/2021.
//

import Foundation

class Users: ObservableObject {
    @Published var items = [User]()
    
    init() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601

                let decodedUsers = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    self.items = decodedUsers
                    print(self.items)
                }
            } catch let error {
                print("error: \(error)")
            }
        }.resume()
        
        //--------------------------------
        
        // The code below returns an error - I think it's caused by the date type on the user array.
        
//        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
//            print("Invalid URL")
//            return
//        }
//
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
//                    // we have good data – go back to the main thread
//
//                    DispatchQueue.main.async {
//                        // update our UI
//                        self.items = decodedResponse
//                    }
//
//                    // everything is good, so we can exit
//                    return
//                }
//            }
//
//            // if we're still here it means there was a problem
//            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
//        }.resume()
        
        //-----------------------------------
        
    }
    
            func findUser(byName name: String) -> User? {
                if let user = items.first(where: { $0.name == name }) {
                    return user
                }
    
                return items.first
            }
    
    
    

    
    
    
    
}


        
