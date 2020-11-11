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
        }
    }
}

struct ToggleStyleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleStyleView()
    }
}
