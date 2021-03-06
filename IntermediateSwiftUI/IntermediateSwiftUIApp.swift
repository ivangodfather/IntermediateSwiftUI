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
                    CustomTabView()
                    AlbumsView()
                    BottomMenuView()
                }
                .tabViewStyle(PageTabViewStyle())
                .tabItem {
                    Image(systemName: "filemenu.and.cursorarrow")
                    Text("Complex views")
                }
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
            .preferredColorScheme(.dark)
        }
    }
}
