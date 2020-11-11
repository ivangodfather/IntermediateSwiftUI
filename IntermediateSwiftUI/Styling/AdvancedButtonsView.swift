//
//  AdvancedButtonsView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 04/11/2020.
//

import SwiftUI

struct AquaButtonStyle: ButtonStyle {
    private let blueH = Color(red: 0.7, green: 1, blue: 1)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .padding(.horizontal)
            .background(
                ZStack {
                    Color(red: 0.3, green: 0.6, blue: 1)
                    Capsule()
                        .inset(by: 8)
                        .offset(y: 8)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [blueH.opacity(0), blueH]), startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 0.8))
                        )
                        .scaleEffect(y: 0.7, anchor: .bottom)
                        .blur(radius: 10)
                    Capsule()
                        .inset(by: 4)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]), startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 0.8))
                        )
                        .scaleEffect(x: 0.95, y: 0.7, anchor: .top)
                    if configuration.isPressed {
                        Color.blue.opacity(0.2)
                    }
                }
            )
            .clipShape(Capsule())
    }
}

struct AdvancedButtonsView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Advance Button").font(.title).bold().padding(.vertical)
            Spacer()
            Button {
                print(".")
            } label: {
                Text("Press me!")
            }.buttonStyle(AquaButtonStyle())
            Spacer()
        }
    }
}

struct AdvancedButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedButtonsView()
    }
}
