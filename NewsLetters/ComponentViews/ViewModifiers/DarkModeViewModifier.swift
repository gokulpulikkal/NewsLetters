//
//  DarkModeViewModifier.swift
//  NewsLetters
//
//  Created by Gokul P on 1/9/25.
//

import Foundation
import SwiftUI

struct DarkModeViewModifier: ViewModifier {
    @AppStorage("isDarkMode") var isDarkMode = true

    public func body(content: Content) -> some View {
        content
            .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

// Add a convenience extension for View
extension View {
    func withDarkMode() -> some View {
        modifier(DarkModeViewModifier())
    }
}
