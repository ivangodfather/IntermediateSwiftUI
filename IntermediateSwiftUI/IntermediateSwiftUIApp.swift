//
//  IntermediateSwiftUIApp.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 03/11/2020.
//

import SwiftUI

@main
struct IntermediateSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                DocumentPropertyWrapperView()
                UserDefaultsPropertyWrapperView()
                ButtonStyleView()
                ToggleStyleView()
                ProgressStyleView()
            }.padding()
            .tabViewStyle(PageTabViewStyle())
        }
    }
}
