//
//  AnimationButtonStyleView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 04/11/2020.
//

import Foundation
import SwiftUI

struct AnimatedCircularButtonStyle: AnimatedButtonStyle {
    let animation: Double
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(Circle())
            .padding()
            .overlay(
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(Color.blue, lineWidth: 4)
                    .rotationEffect(Angle.init(degrees: 360 * animation))
            )
            .padding()
            .overlay(
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(Color.blue, lineWidth: 4)
                    .rotationEffect(Angle.init(degrees: 360 * -animation))
            )
    }
}



struct PulsingButtonStyle: AnimatedButtonStyle {
    let animation: Double

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .clipShape(Circle())
            .foregroundColor(.white)
            .padding(4)
            .overlay(
                Circle().stroke(Color.blue, lineWidth: 2)
                    .scaleEffect(CGFloat(1 + animation))
                    .opacity(1 - animation)
            )
            
    }
}

struct AnimatedButton<Style: AnimatedButtonStyle, Content: View>: View {
    let style: Style.Type
    let action: () -> Void
    let label: () -> Content
    var animationSpeed = 1.0
    
    @State private var animation = 0.0
    
    var body: some View {
        Button(action: action, label: label)
            .buttonStyle(Style.init(animation: animation))
            .onAppear {
                withAnimation(Animation.easeOut(duration: animationSpeed).repeatForever(autoreverses: false)) {
                    animation = 1
                }
            }
    }
}

protocol AnimatedButtonStyle: ButtonStyle {
    init(animation: Double)
}

struct AnimationButtonStyleView: View {

    var body: some View {
        VStack(spacing: 64) {
            AnimatedButton(style: AnimatedCircularButtonStyle.self) {
                print("Pressed")
            } label: {
                Image(systemName: "star")
            }
            AnimatedButton(style: PulsingButtonStyle.self) {
                print("Pressed")
            } label: {
                Image(systemName: "star")
            }
        }
        
    }
}

struct AnimationButtonStyleView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationButtonStyleView()
    }
}
