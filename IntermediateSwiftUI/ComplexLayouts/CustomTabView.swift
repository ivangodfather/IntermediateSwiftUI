//
//  CustomTabView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 11/11/2020.
//

import SwiftUI

struct CustomTabView: View {
    @State private var selected = "house"
    var tabBarItems = ["house", "magnifyingglass", "terminal", "book", "person"]
    @State private var centerX: CGFloat = 0

    var body: some View {
        VStack {
            TabView(selection: $selected) {
                ForEach(tabBarItems, id: \.self) {
                    Text($0).tag($0)
                }
            }.padding(.bottom)
            HStack {
                ForEach(tabBarItems, id: \.self) { value in
                    GeometryReader { geo in
                        TabItem(value: value, selected: $selected, centerX: $centerX) {
                            withAnimation(Animation.spring(response: 0.4, dampingFraction: 0.5)) {
                                centerX = geo.frame(in: .global).midX
                            }
                        }
                            .onAppear {

                                centerX = geo.frame(in: .global).midX
                            }
                    }.frame(width: 20, height: 10)
                    if value != tabBarItems.last {
                        Spacer()
                    }
                }
            }
            .padding(.vertical, 15)
            .padding(.bottom, 25)
            .padding(.horizontal)
            .background(Color.gray.opacity(0.2).clipShape(MyShape(centerX: centerX)))
        }.ignoresSafeArea(.all, edges: .bottom)
        .tabViewStyle(DefaultTabViewStyle())
        .padding(.bottom, 64)

    }
}

struct TabItem: View {
    let value: String
    @Binding var selected: String
    @Binding var centerX: CGFloat
    let selectionBlock: () -> ()

    var body: some View {
        Button(action: { selected = value; selectionBlock(); }) {
            Image(systemName: value).foregroundColor(selected == value ? .accentColor : .gray)


        }
    }
}

struct MyShape: Shape {

    var centerX: CGFloat
    private let widthSelection:CGFloat = 40

    var animatableData: CGFloat {
        get { centerX }
        set { centerX = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.move(to: CGPoint(x: centerX - widthSelection, y: 0))
        path.addQuadCurve(to: CGPoint(x: centerX + widthSelection, y: 0), control: CGPoint(x: centerX, y: -32))

        return path
    }
}


struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
