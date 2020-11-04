//
//  UserDefaultsView.swift
//  IntermediateSwiftUI
//
//  Created by Ivan Ruiz Monjo on 03/11/2020.
//

import SwiftUI

// Stores data into UserDefaults

@propertyWrapper struct MyStorage<T>: DynamicProperty {
    private let key: String
    private let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get { UserDefaults.standard.value(forKey: key) as? T ?? defaultValue }
        nonmutating set { UserDefaults.standard.setValue(newValue, forKey: key) }
    }

    var projectedValue: Binding<T>  {
        Binding(get: { wrappedValue }, set: { wrappedValue = $0})
    }
}

struct UserDefaultsPropertyWrapperView: View {
    @MyStorage<String>("myOtherFile.txt", defaultValue: "Write your own stuff") var document
    var body: some View {
        VStack {
            Text("User defaults property wrapper").font(.title)
            TextEditor(text: $document)
        }
    }
}

struct UserDefaultsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultsPropertyWrapperView()
    }
}
