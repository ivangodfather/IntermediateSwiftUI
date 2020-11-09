//
//  PrimitiveButtonsView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 05/11/2020.
//

import SwiftUI
import Combine

#if DEBUG
typealias CustomButtonType = DebugButtonStyle
#else
typealias CustomButtonType = ExampleButtonStyle
#endif

struct DebugButtonStyle: PrimitiveButtonStyle {
    let location: String

    func makeBody(configuration: Configuration) -> some View {
        Button {
            print("Button pressend on \(location)")
            configuration.trigger()
        } label: {
            configuration.label
        }.buttonStyle(ExampleButtonStyle())
    }

    init(file: String = #file, line: Int = #line) {
        location = "\(file) in \(line)"
    }
}

struct ExampleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}

struct CancellableButtonStyle: PrimitiveButtonStyle {

    private struct CancellableButton: View {
        let configuration: Configuration
        let timeOut: Int
        @State private var timerSubscription: Cancellable?
        @State private var timer = Timer.publish(every: 1, on: .main, in: .common)
        @State private var countDown = 0

        var body: some View {
            Button {
                if timerSubscription == nil {
                    timer = Timer.publish(every: 1, on: .main, in: .common)
                    timerSubscription = timer.connect()
                    countDown = timeOut
                } else {
                    cancelTimer()

                }
            } label : {
                if timerSubscription == nil {
                    configuration.label
                } else {
                    Text("Cancel ? \(countDown)")
                }
            }.onReceive(timer) { _ in
                if countDown > 1 {
                    countDown -= 1
                } else {
                    configuration.trigger()
                    cancelTimer()
                }
            }
        }

        func cancelTimer() {
            timerSubscription?.cancel()
            timerSubscription = nil
        }
    }

    var timeOut = 3

    func makeBody(configuration: Configuration) -> some View {
        CancellableButton(configuration: configuration, timeOut: timeOut)
    }


}

struct PrimitiveButtonsView: View {
    var body: some View {
            VStack(spacing: 64) {
                Button {
                    print("pressed")
                } label: {
                    Text("Press me")
                }.buttonStyle(CustomButtonType())
                Button {
                    print("launched!")
                } label: {
                    Text("Launch")
                }.buttonStyle(CancellableButtonStyle())
            }

    }
}

struct PrimitiveButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PrimitiveButtonsView()
    }
}
