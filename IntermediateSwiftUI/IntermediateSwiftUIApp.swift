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
                TabView {
                    BarChartView()
                    PieChartView()
                    LineChartView()
                }
                .tabViewStyle(PageTabViewStyle())
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("Charts")
                }
                TabView {
                    AnimationButtonStyleView()
                    ButtonStyleView()
                    AdvancedButtonsView()
                    ToggleStyleView()
                    ProgressStyleView()
                }
                .tabViewStyle(PageTabViewStyle())
                .tabItem {
                    Image(systemName: "square.on.circle")
                    Text("Buttons")
                }

            }
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .tabViewStyle(DefaultTabViewStyle())
//            TabView {
//                DocumentPropertyWrapperView()
////                UserDefaultsPropertyWrapperView()
//
//
////                LabelStyleView()
//                AdvancedButtonsView()
//            }.padding()
//            .tabViewStyle(PageTabViewStyle())
        }
    }
}
