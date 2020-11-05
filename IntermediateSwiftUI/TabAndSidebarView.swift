//
//  TabAndSidebarView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 05/11/2020.
//

import SwiftUI

struct TitledView {
    let title: String
    let icon: Image
    let view: AnyView

    init<T: View>(title: String, systemImage: String, view: T) {
        self.title = title
        self.icon = Image(systemName: systemImage)
        self.view = AnyView(view)
    }
}

struct TabbedSideBar: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    private let views: [TitledView]
    @State private var selection: String? = ""

    init(content: [TitledView]) {
        views = content
        _selection = State(wrappedValue: content[0].title)
    }

    var body: some View {
        if sizeClass == .compact {
            TabView(selection: $selection) {
                ForEach(views, id: \.title) { item  in
                    item.view
                        .tabItem {
                            Text(item.title)
                            item.icon
                        }
                        .tag(item.title)
                }
            }
        } else {
            NavigationView {
                List(selection: $selection) {
                    ForEach(views, id: \.title) { item in
                        NavigationLink(destination: item.view, tag: item.title, selection: $selection) {
                            Label {
                                Text(item.title)
                            } icon: {
                                item.icon
                            }
                        }.tag(item.title)
                    }
                }.listStyle(SidebarListStyle())
            }
        }
    }
}

struct TabAndSidebarView: View {
    var body: some View {
        TabbedSideBar(content: [
            TitledView(title: "Home", systemImage: "house", view: Text("Home")),
            TitledView(title: "Buy", systemImage: "cart", view: Text("Buy")),
            TitledView(title: "Account", systemImage: "person.circle", view: Text("Account"))
        ])
    }
}

struct TabAndSidebarView_Previews: PreviewProvider {
    static var previews: some View {
        TabAndSidebarView()
    }
}
