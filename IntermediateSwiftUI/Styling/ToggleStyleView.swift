//
//  ToggleStyleView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 03/11/2020.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
            Button(action: { configuration.isOn.toggle() }, label: {
                HStack {
                    configuration.label
                    Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(configuration.isOn ? .accentColor : .secondary)
                }

            })

    }
}

struct ToggleStyleView: View {
    @State private var showDetail = false
    var body: some View {
        VStack {
            Text("Custom toggle").font(.title).bold().padding(.vertical)
            Spacer()
            Toggle("Show detail", isOn: $showDetail)
                .toggleStyle(CheckboxToggleStyle())
            Spacer()
            StarShape()
                .stroke(Color.red, lineWidth: 1)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 100, height: 100)
        }
    }
}

struct ToggleStyleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleStyleView()
    }
}

struct StarShape: Shape {

    let numberOfSegments = 8
    let innerRatio: CGFloat = 0.4

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let outerRadious = min(rect.width, rect.height) / 2
        let innerRadious = outerRadious * innerRatio
        let angleStep = .pi * 2 / CGFloat(numberOfSegments)

        path.move(to: CGPoint(x: rect.midX, y: rect.midY - outerRadious))

        for index in 1..<numberOfSegments {

            let radious = index.isMultiple(of: 2) ? outerRadious : innerRadious
            let angle = CGFloat(index) * angleStep
            let xOffset = sin(angle) * radious
            let yOffset = cos(angle) * radious
            path.addLine(to: CGPoint(x: rect.midX + xOffset, y: rect.midY - yOffset))
        }
        path.closeSubpath()

        return path
    }

}

struct StarPreview_Previews: PreviewProvider {
    static var previews: some View {
        StarShape().stroke(Color.red, lineWidth: 1)
            .frame(width: 100)
    }
}
