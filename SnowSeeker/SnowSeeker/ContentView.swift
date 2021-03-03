//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Alejandro Fresneda on 28/02/2021.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    let countries = ["All", "France", "Austria", "Canada", "Italy", "United States"]
    @State private var countrySelection = 0
    
    var filteredByCountry: [Resort] {
        switch countrySelection {
        case 0:
            return resorts
        case 1:
            return resorts.filter { $0.country == "France" }
        case 2:
            return resorts.filter { $0.country == "Austria" }
        case 3:
            return resorts.filter { $0.country == "Canada" }
        case 4:
            return resorts.filter { $0.country == "Italy" }
        default:
            return resorts.filter { $0.country == "United States" }
        }
    }
    
    let prices = ["All", "$", "$$", "$$$"]
    @State private var priceSelection = 0
    
    var filteredByPrice: [Resort] {
        switch priceSelection {
        case 0:
            return filteredByCountry
        case 1:
            return filteredByCountry.filter { $0.price == 1 }
        case 2:
            return filteredByCountry.filter { $0.price == 2 }
        default:
            return filteredByCountry.filter { $0.price == 3 }
            
        }
    }
    
    let sizes = ["All", "Small", "Average", "Large"]
    @State private var sizeSelection = 0
    
    var filteredBySize: [Resort] {
        switch sizeSelection {
        case 0:
            return filteredByPrice
        case 1:
            return filteredByPrice.filter { $0.size == 1 }
        case 2:
            return filteredByPrice.filter { $0.size == 2 }
        default:
            return filteredByPrice.filter { $0.size == 3 }
            
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Filters")) {
                    Picker("Countries", selection: $countrySelection) {
                        ForEach(0..<countries.count) {
                            Text("\(self.countries[$0])")
                        }
                    }
                    Picker("Price", selection: $priceSelection) {
                        ForEach(0..<prices.count) {
                            Text("\(self.prices[$0])")
                        }
                    }
                    Picker("Size", selection: $sizeSelection) {
                        ForEach(0..<sizes.count) {
                            Text("\(self.sizes[$0])")
                        }
                    }
                }
                Section(header: Text("Results")) {
                    List(filteredBySize) { resort in
                        NavigationLink(destination: ResortView(resort: resort)) {
                            Image(resort.country)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .overlay(RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.black, lineWidth: 1)
                                )
                            VStack(alignment: .leading) {
                                Text(resort.name)
                                    .font(.headline)
                                
                                Text("\(resort.runs) runs")
                                    .foregroundColor(.secondary)
                            }
                            .layoutPriority(1)
                            
                            if self.favorites.contains(resort) {
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .accessibility(label: Text("This is a favorite resort"))
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            
            .navigationTitle("Resorts")
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
