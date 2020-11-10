//
//  ColoredButtonStyleView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 03/11/2020.
//

import SwiftUI

struct ColoredButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .padding(.horizontal, 50)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
            .overlay(
                Color.black
                    .opacity(configuration.isPressed ? 0.3 : 0)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
    }
}

struct StripedRectangleButtonStyle: ButtonStyle {
    var offColor = Color.blue
    var onColor = Color.green

    func color(for configuration: Configuration) -> Color {
        configuration.isPressed ? onColor : offColor
    }

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Rectangle()
                .fill(color(for: configuration))
                .frame(width: 10)

            configuration.label
                .padding()
                .foregroundColor(color(for: configuration))
                .textCase(.uppercase)
                .font(Font.title.bold())
                .border(color(for: configuration), width: 4)
        }
        .fixedSize()
        .animation(nil)
    }
}

struct PushButtonStyle: ButtonStyle {
    let lightGray = Color(white: 0.8)

    func makeBody(configuration: Self.Configuration) -> some View {
        let startEdge: UnitPoint
        let endEdge: UnitPoint

        if configuration.isPressed {
            startEdge = UnitPoint.bottomTrailing
            endEdge = UnitPoint.topLeading
        } else {
            startEdge = UnitPoint.topLeading
            endEdge = UnitPoint.bottomTrailing
        }

        return configuration.label
            .foregroundColor(Color.gray.opacity(configuration.isPressed ? 0.7 : 1))
            .font(.largeTitle)
            .padding(40)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.05), .white]), startPoint: startEdge, endPoint: endEdge)
            )
            .overlay(
                Circle()
                    .stroke(
                        LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]), startPoint: startEdge, endPoint: endEdge),
                        lineWidth: 16
                    )
                    .padding(2)

            )
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .shadow(color: Color.black.opacity(configuration.isPressed ? 0 : 0.2), radius: 10, x: 10, y: 10)
            .animation(nil)
    }
}

struct ButtonStyleView: View {
    var body: some View {
        VStack {
            Text("Button Styles").font(.title).bold().padding(.vertical)
            Spacer()
            Button(action: {}, label: {
                Text("Button")
            }).buttonStyle(ColoredButtonStyle(color: .blue))
            Button(action: {}, label: {
                Text("Button")
            }).buttonStyle(StripedRectangleButtonStyle())
            Button(action: {}, label: {
                Image(systemName: "star")
            }).buttonStyle(PushButtonStyle())
            Spacer()
        }
    }
}

struct ColoredButtonStyleView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleView()
    }
}
