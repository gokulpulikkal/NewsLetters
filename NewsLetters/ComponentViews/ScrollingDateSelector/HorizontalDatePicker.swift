// Create a new file called HorizontalDatePicker.swift
import SwiftUI

struct HorizontalDatePicker: View {
    @Binding var selectedDate: Date
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private let weekDayFormatter = DateFormatter()
    
    // Number of days to show before and after today
    private let daysRange = 15
    
    init(selectedDate: Binding<Date>) {
        self._selectedDate = selectedDate
        dateFormatter.dateFormat = "dd"
        weekDayFormatter.dateFormat = "EE"
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Today")
                .font(.title)
                .fontWeight(.bold)
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(-daysRange...daysRange, id: \.self) { dayOffset in
                            let date = calendar.date(byAdding: .day, value: dayOffset, to: Date()) ?? Date()
                            DateCell(date: date, isSelected: calendar.isDate(date, inSameDayAs: selectedDate))
                                .onTapGesture {
                                    selectedDate = date
                                }
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
}

struct DateCell: View {
    let date: Date
    let isSelected: Bool
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private let weekDayFormatter = DateFormatter()
    
    init(date: Date, isSelected: Bool) {
        self.date = date
        self.isSelected = isSelected
        dateFormatter.dateFormat = "dd"
        weekDayFormatter.dateFormat = "EE"
    }
    
    var body: some View {
        VStack {
            Text(weekDayFormatter.string(from: date).uppercased())
                .font(.caption)
                .foregroundColor(.gray)
            
            ZStack {
                Circle()
                    .fill(isSelected ? Color.green : Color.clear)
                    .frame(width: 40, height: 40)
                
                Text(dateFormatter.string(from: date))
                    .font(.title3)
                    .foregroundColor(isSelected ? .white : .primary)
            }
        }
        .frame(width: 50)
    }
}

// End of file. No additional code.
