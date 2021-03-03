//
//  ContentView.swift
//  Drawing
//
//  Created by Alejandro Fresneda on 20/12/2020.
//

import SwiftUI

struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct Square: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.minY))
        
        return path
    }
}

struct ContentView: View {
    @State private var thickness: CGFloat = 1.0
    
    var body: some View {
        VStack (spacing: 0) {
            Triangle()
                .stroke(Color.blue, style: StrokeStyle(lineWidth: thickness, lineCap: .round, lineJoin: .round))
                .frame(width: 150, height: 200)
            Square()
                .stroke(Color.blue, style: StrokeStyle(lineWidth: thickness, lineCap: .round, lineJoin: .round))
                .frame(width: 20, height: 200)
            Slider(value: $thickness, in: 1...9)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



