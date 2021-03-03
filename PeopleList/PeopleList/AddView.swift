//
//  AddView.swift
//  PeopleList
//
//  Created by Alejandro Fresneda on 06/02/2021.
//
import CoreImage
import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingImagePicker = false
    
    @ObservedObject var people: People
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var name = ""
    
    var body: some View {
        return NavigationView {
            VStack {
                TextField("Enter name", text: $name)
                if let image = image {
                    image
                        .resizable()
                        .scaledToFit()
                } else {
                    Button(action: {
                        self.showingImagePicker = true
                    }){
                        Text("Select image")
                    }
                }
            }
            .navigationBarTitle("Add person")
            .navigationBarItems(
                leading: Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                    
                },
                trailing: Button("Save") {
                    let item = Person(name: self.name)
                    self.people.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                    self.saveData()
                    print("person saved")
            
            } )
        }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPeople")
            let data = try JSONEncoder().encode(self.people)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
//            if let jpegData = inputImage!.jpegData(compressionQuality: 0.8) {
//                try? jpegData.write(to: filename, options: [.atomicWrite, .completeFileProtection])
//            }
            
        } catch {
            print("Unable to save data.")
        }
    }
}
