//
//  SwiftUIView.swift
//  
//
//  Created by Klaus Kneupner on 25/06/2024.
//

import SwiftUI

struct HeightReader: View {
    @Binding var height: CGSize

    var body: some View {
        GeometryReader { geo in
            Color.clear
                .preference(key: ViewSizeKey.self, value: geo.size)
                .onPreferenceChange(ViewSizeKey.self) { value in
                    self.height = value
                }
        }
    }
}

struct ViewSizeKey: PreferenceKey {
    static var defaultValue: CGSize = CGSize(width: 1, height: 1)

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}


#Preview {
    struct ContentView: View {
        @State private var viewHeight: CGSize = CGSize(width: 1, height: 1)

        var body: some View {
            ZStack {
                HeightReader(height: $viewHeight)
                Text("View height: \(viewHeight)")
            }
        }
    }
    return ContentView()
}
