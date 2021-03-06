//
//  ProgressStyleView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 03/11/2020.
//

import SwiftUI

struct CustomProgressViewStyle: ProgressViewStyle {
    var trimAmount = 0.7
    var strokeColor = Color.red
    var strokeWidth = 25.0
    var rotation: Angle {
        Angle(radians: .pi * (1 - trimAmount)) + Angle(radians: .pi / 2)
    }
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
            Circle()
                .rotation(rotation)
                .trim(from: 0.0, to: CGFloat(trimAmount))
                .stroke(strokeColor.opacity(0.5), style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round ))
            Circle()
                .rotation(rotation)
                .trim(from: 0.0, to: CGFloat(trimAmount * fractionCompleted))
                .stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round ))
        }
    }
}

struct ProgressStyleView: View {
    @State private var progress = 0.0

    var body: some View {
        VStack {
            Text("Custom PorgressView").font(.title).bold().padding(.vertical)
            ProgressView("Test", value: progress)
                .progressViewStyle(CustomProgressViewStyle())
                .frame(width: 200)
            Button {
                    withAnimation {
                        if progress < 1 {
                            progress += 0.2
                        } else {
                            progress = 0
                        }
                    }
            } label: {
                Text("Update Progress").font(.title)
                    .fontWeight(.bold).padding(.bottom, 64)
            }
        }

    }
}

struct ProgressStyleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressStyleView()
    }
}
