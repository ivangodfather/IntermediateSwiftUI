//
//  PieChartView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 09/11/2020.
//

import SwiftUI

struct PieData {
    let id: Int
    let value: Double
    let color: Color
}

struct PieSegment: Shape, Identifiable {
    let pieData: PieData
    var startAngle: Double
    var amount: Double
    var id: Int { pieData.id }

    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(startAngle, amount) }
        set { startAngle = newValue.first; amount = newValue.second }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        path.move(to: center)
        path.addRelativeArc(center: center, radius: radius, startAngle: Angle(radians: startAngle), delta: Angle(radians: amount))
        return path
    }
}


struct PieChart: View {
    let segments: [PieSegment]

    init(pieData: [PieData]) {
        var segments = [PieSegment]()
        let totalPie = pieData.reduce(0) { $0 + $1.value }
        var startAngle = -Double.pi / 2
        for data in pieData {
            let amount = Double.pi * 2 * data.value / totalPie
            let segment = PieSegment(pieData: data, startAngle: startAngle, amount: amount)
            segments.append(segment)
            startAngle += amount
        }
        self.segments = segments
    }

    var body: some View {
        ZStack {
            ForEach(segments) {
                $0
                    .fill($0.pieData.color)
            }
        }
    }
}

struct PieChartView: View {

    @State var pieData: [PieData]? = nil

    var body: some View {
        VStack {
            if let pieData = pieData {
                PieChart(pieData: pieData).onTapGesture(perform: loadData)
            } else {
                Text("Loading data...!")
                    .onAppear(perform: loadData)
            }
        }

    }

    func loadData() {
        withAnimation {
            pieData = [
                PieData(id: 1, value: Double.random(in: 1...10), color: .red),
                PieData(id: 2, value: Double.random(in: 1...10), color: .yellow),
                PieData(id: 3, value: Double.random(in: 1...10), color: .green),
                PieData(id: 4, value: Double.random(in: 1...10), color: .blue)
            ]
        }

    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView()
    }
}
