//
//  HorizontalDatePicker.swift
//  NewsLetters
//
//  Created by Gokul P on 1/7/25.
//

import SwiftUI

struct HorizontalDatePicker: View {
    @Binding var selectedDate: Date
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private let weekDayFormatter = DateFormatter()

    /// Number of days to show before today
    private let daysRange = 15

    /// Animation name space for the matched geometry animation in date cells
    @Namespace private var animationNameSpace

    init(selectedDate: Binding<Date>) {
        self._selectedDate = selectedDate
        dateFormatter.dateFormat = "dd"
        weekDayFormatter.dateFormat = "EE"
    }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(-daysRange...0, id: \.self) { dayOffset in
                        let date = calendar.date(byAdding: .day, value: dayOffset, to: Date()) ?? Date()
                        let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
                        dateCell(date: date, isSelected: isSelected)
                            .id(dayOffset)
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                // Scroll to today's date
                proxy.scrollTo(0, anchor: .center)
            }
        }
    }
}

extension HorizontalDatePicker {
    @ViewBuilder
    func dateCell(date: Date, isSelected: Bool) -> some View {
        VStack {
            Text(weekDayFormatter.string(from: date).uppercased())
                .font(.caption)
                .foregroundColor(.gray)

            ZStack {
                if isSelected {
                    Circle()
                        .fill(Color(uiColor: .fillColorWB))
                        .frame(width: 40, height: 40)
                        .matchedGeometryEffect(id: "dateSelection", in: animationNameSpace)
                }
                Text(dateFormatter.string(from: date))
                    .font(.title3)
                    .foregroundColor(isSelected ? Color(uiColor: .textColorBW) : Color(UIColor.label))
            }
        }
        .frame(width: 50)
        .onTapGesture {
            withAnimation(.spring(duration: 0.3)) { // Add animation
                selectedDate = date
            }
        }
    }
}

#Preview {
    HorizontalDatePicker(selectedDate: .constant(.now))
}
