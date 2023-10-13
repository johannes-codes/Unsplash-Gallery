//
//  ContentView.swift
//  Unsplash Gallery
//
//  Created by Meißner, Johannes, HSE DE on 12.10.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
