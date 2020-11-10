//
//  BarChartView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 09/11/2020.
//

import SwiftUI

struct BarChartData: Identifiable {
    let value: Double
    let color: Color
    let title: String

    var id: Color {
        color
    }
}

struct BarChart: View {

    let data: [BarChartData]
    let maxValue: Double

    init(data: [BarChartData]) {
        self.data = data
        maxValue = 100 //data.max { $0.value < $1.value }?.value ?? 1
    }

    var body: some View {
        ZStack {
            HStack(spacing: 16) {
                VStack {
                    ForEach((1...10).reversed(), id: \.self) { i in
                        Text(String(Int(maxValue / 10 * Double(i)))).bold()
                        Spacer()
                    }
                }
                .animation(nil)
                ForEach(data) { bar in
                    VStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(bar.color)
                            .scaleEffect(y: CGFloat(bar.value / maxValue), anchor: .bottom)
                            .shadow(color: bar.color.opacity(0.8), radius: 16)
                        Text(bar.title).bold()
                    }
                }

            }
            VStack {
                ForEach(1...10, id: \.self) { _ in
                    Divider()
                    Spacer()
                }
            }
        }
    }
}

struct BarChartView: View {
    @State private var data: [BarChartData] = []

    var body: some View {
        VStack {
            if data.isEmpty {
                Text("Loading").onAppear(perform: makeData)
            }
            BarChart(data: data)
        }
        .padding()
        .onTapGesture(perform: makeData)
    }

    func makeData() {
        withAnimation {
            data = [
                BarChartData(value: Double.random(in: 1...100), color: .red, title: "Yes"),
                BarChartData(value: Double.random(in: 1...100), color: .green, title: "No"),
                BarChartData(value: Double.random(in: 1...100), color: .blue, title: "Maybe"),
                BarChartData(value: Double.random(in: 1...100), color: .yellow, title: "?"),
            ]
        }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView()
    }
}
