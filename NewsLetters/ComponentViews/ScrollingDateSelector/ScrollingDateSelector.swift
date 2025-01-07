//
//  ScrollingDateSelector.swift
//  NewsLetters
//
//  Created by Gokul P on 1/7/25.
//

import SwiftUI

struct ScrollingDateSelector: View {
    @State private var selectedDate = Date()
    var body: some View {
        VStack {
            // Add HorizontalDatePicker
            HorizontalDatePicker(selectedDate: $selectedDate)
                .padding(.vertical)

            // Example of using the selected date
            Text("Selected date: \(selectedDate.formatted(date: .long, time: .omitted))")
                .padding()
        }
    }
}

#Preview {
    ScrollingDateSelector()
}
