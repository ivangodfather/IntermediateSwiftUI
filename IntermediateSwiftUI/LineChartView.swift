//
//  LineChartView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 09/11/2020.
//

import SwiftUI

struct LineChartShape: Shape {

    let data: [Double]
    let showBullets: Bool
    private let pointSize = CGFloat(4)

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let insectRect = rect.insetBy(dx: pointSize, dy: pointSize)

        for (index, value) in data.enumerated() {
            var x = CGFloat(index) * insectRect.width / CGFloat(data.count - 1)
            var y = insectRect.height * CGFloat(value) / CGFloat(data.max()!)
            y = insectRect.height - y

            x += insectRect.minX
            y += insectRect.minY
            let point = CGPoint(x: x, y: y)

            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
            if showBullets {
                x -= pointSize / 2
                y -= pointSize / 2
                path.addEllipse(in: CGRect(x: x, y: y, width: pointSize, height: pointSize))
            }


        }
        return path
    }
}

struct LineChart: View {
    let data: [Double]
    let showBullets: Bool
    let color: Color

    var body: some View {
        LineChartShape(data: data, showBullets: showBullets)
            .stroke(color, lineWidth: 1.0)
    }
}

struct LineChartView: View {
    let data: [Double] = [0, 1.5, 3, 5, 4, 2, 3, 4, 4.5, 6, 7, 5]
    
    var body: some View {
        LineChart(data: data, showBullets: true, color: .blue)
    }
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView().background(Color.orange)
    }
}
