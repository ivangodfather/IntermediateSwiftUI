//
//  LabelStyleView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 04/11/2020.
//

import SwiftUI

protocol HoveringLabelStyle: LabelStyle {
    init(hovering: Bool)
}

struct HoveringLabel<LabelStyle: HoveringLabelStyle, Title: View, Icon: View>: View {
    let labelStyle: LabelStyle.Type
    let title: () -> Title
    let icon: () -> Icon

    @State private var isHovered = false

    var body: some View {
        Label(title: title, icon: icon)
            .labelStyle(labelStyle.init(hovering: isHovered))
            .onHover { isOver in
                withAnimation {
                    isHovered = isOver
                }
            }
            .contentShape(Circle())
    }
}

struct RevealingLabelStyle: HoveringLabelStyle {
    let hovering: Bool
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
            configuration.title
                .opacity(hovering ? 1 : 0)
        }
    }
}

struct VerticalLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
                .imageScale(.large)
            configuration.title
        }
        .padding()
        .overlay(Capsule().stroke(Color.accentColor, lineWidth: 2))
    }
}

struct LabelStyleView: View {
    var body: some View {
        VStack {
            Label {
                Text("Home")
            } icon: {
                Image(systemName: "house")
            }.labelStyle(VerticalLabelStyle())
            Label("Home", systemImage: "house")
                .labelStyle(IconOnlyLabelStyle())
            HoveringLabel(labelStyle: RevealingLabelStyle.self) {
                Text("Test")
            } icon: {
                Image(systemName: "car")
            }
        }
    }
}

struct LabelStyleView_Previews: PreviewProvider {
    static var previews: some View {
        LabelStyleView()
    }
}
