//
//  CardView.swift
//  Flashzilla
//
//  Created by Alejandro Fresneda on 19/02/2021.
//

import SwiftUI

struct CardView: View {
    //use this to track wheter the user has the differentiate without color setting enabled
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    //Currently swiftUI doesn't have an environment wrapper to track if voice over is enabled - instead, we have to use accessibilityEnabled (this doesn't affect things like differentiate with color or reduced motion
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    let card: Card
    var removal: (() -> Void)? = nil
    
    @State private var isShowingAnswer = false
    
    //this tracks how far the users drag the card
    @State private var offset = CGSize.zero
    
    //add haptic feedback generator
    @State private var feedback = UINotificationFeedbackGenerator()
    
    //success counter
    @State private var successCounter = 0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor ? Color.white : Color.white
                        .opacity(1 - Double(abs(offset.width / 50))))
                //change colour based on the direction of the swipe to indicate right or wrong - if differentiate without color is disabled
                .background(
                    differentiateWithoutColor ? nil : RoundedRectangle(cornerRadius: 25, style: .continuous).fill(offset.width > 0 ? Color.green : Color.red)
                )
                .shadow(radius: 10)
            
            VStack {
                //if voiceover is enabled, then show the questions or the answer but not both at the same time
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        //apply rotation effect based on the screen width offset divided by 5
        .rotationEffect(.degrees(Double(offset.width / 5)))
        //apply translation effect based on the screen width offset multiplied by 5
        .offset(x: offset.width * 2, y: 0)
        //modify opacity - keep it opaque for a while until the user has dragged the card more than 100points
        .opacity(3 - Double(abs(offset.width / 100)))
        //give a hint to voice over users that card can be tapped
        .accessibility(addTraits: .isButton)
        //gesture modifier to track drag. If user releases the card after dragging it more than 100pts to either side, then remove card. Otherwise, set offset to 0 (i.e. return card to the pile when the user releases it
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                    self.feedback.prepare()
                }
                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        if self.offset.width > 0 {
                            self.feedback.notificationOccurred(.success)
                            self.successCounter += 1
                        } else {
                            self.feedback.notificationOccurred(.error)
                        }

                        self.removal?()
                    } else {
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
