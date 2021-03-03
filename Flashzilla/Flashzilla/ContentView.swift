//
//  ContentView.swift
//  Flashzilla
//
//  Created by Alejandro Fresneda on 17/02/2021.
//

import CoreHaptics
import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView: View {
    //to read if differentiate without color is enabled
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    //to read if accessibility settings enabled (voice over)
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    @State private var cards = [Card]()
    
    //track if app is active
    @State private var isActive = true
    
    //create timer
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //track if showing card edit screen
    @State private var showingEditScreen = false
    
    //add haptic feedback generator
    //    @State private var feedback = UINotificationFeedbackGenerator()
    @State private var engine: CHHapticEngine?
    
    @State private var timerEnd = false
    
    @State private var loopCards = false
    
    var body: some View {
        ZStack {
            Color(.gray)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                ZStack {
                    ZStack {
                        ForEach(0..<cards.count, id: \.self) { index in
                            CardView(card: self.cards[index]) {
                                withAnimation {
                                    self.removeCard(at: index)
                                }
                            }
                            .stacked(at: index, in: self.cards.count)
                            //only allow to swipe the card at the top
                            .allowsHitTesting(index == self.cards.count - 1)
                            //hide text from hidden cards for voice over
                            .accessibility(hidden: index < self.cards.count - 1)
                        }
                        
                    }
                    .allowsHitTesting(timeRemaining > 0)
                    
                    if timeRemaining == 0 {
                        
                        VStack {
                            
                            Text("Your time is up!")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Button("Start Again", action: resetCards)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .clipShape(Capsule())
                        }
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                    }
                }
                
                //show reset button when user has swipped all the cards
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
                
            }
            
            VStack {
                HStack {
                    Toggle("Loop cards", isOn: $loopCards)
                    
                    Spacer()
                    
                    Button(action: {
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                }
                
                Spacer()
            }
            
            .padding()
            
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.removeCard(at:
                                                    self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard self.isActive else { return }
            
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
            
            if self.timeRemaining == 0 && !timerEnd {
                self.prepareHaptics()
                self.timeIsOut()
                self.timerEnd = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            //don't restart the timer if the deck of cards is empty
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards()
        }
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int) {
        
        if !loopCards {
            guard index >= 0 else { return }
            cards.remove(at: index)
        } else {
            //if card swiped left, send to end of the Stack
        }
        
        //stop timer if last card is swiped
        if cards.isEmpty {
            isActive = false
        }
    }
    
    //reset app
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
        timerEnd = false
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func timeIsOut() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        // create one intense, sharp tap
        //        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        //        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        //        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        //        events.append(event)
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
