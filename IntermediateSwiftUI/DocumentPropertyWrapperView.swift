//
//  ContentView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 03/11/2020.
//

import SwiftUI

// Stores data into a file

@propertyWrapper struct Document: DynamicProperty {
    @State private var value = ""
    private let url: URL

    init(_ filename: String) {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        url = documentsPath.appendingPathComponent(filename)
        let text = (try? String(contentsOf: url)) ?? ""
        _value = State(wrappedValue: text)
    }

    var wrappedValue: String {
        get {
            value
        }
        nonmutating set {
            do {
                try newValue.write(to: url, atomically: true, encoding: .utf8)
                value = newValue
            } catch {
                print("err")
            }
        }
    }

    var projectedValue: Binding<String> {
        Binding (
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
}

struct DocumentPropertyWrapperView: View {
    @Document("myFile.txt") var document
    var body: some View {
        VStack {
            Text("Document property wrapper").font(.title)
            TextEditor(text: $document)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentPropertyWrapperView()
    }
}
