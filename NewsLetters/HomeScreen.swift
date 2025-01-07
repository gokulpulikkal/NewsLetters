//
//  HomeScreen.swift
//  NewsLetters
//
//  Created by Gokul P on 1/7/25.
//

import SwiftUI

struct HomeScreen: View {
    var categories: [String] = ["All", "Fiction", "Science", "LifeStyle"]
    @State var selectedCategory = "Fiction"
    @State private var selectedDate = Date()
    
    var body: some View {
        AutoHidingHeaderView(content: {
            dummyThumbnails()
        }, header: {
            customHeader()
        })
    }
}

extension HomeScreen {
    @ViewBuilder
    func customHeader() -> some View {
        VStack(spacing: 5) {
            HStack {
                Text("Today")
                    .font(.system(size: 30, weight: .bold))
                Spacer()
                HStack(spacing: 18) {
                    Button(action: {}, label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .fontWeight(.bold)
                    })
                    .buttonStyle(.plain)
                    Button(action: {}, label: {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .fontWeight(.bold)
                    })
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
            HorizontalDatePicker(selectedDate: $selectedDate)
            categoryViews()
        }
        .padding(.top, safeArea().top + 20)
        .background {
            Color.primaryBackGround
                .ignoresSafeArea()
        }
        .padding(.top, -15)
    }

    @ViewBuilder
    func categoryViews() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        withAnimation {
                            selectedCategory = category
                        }
                        
                    }, label: {
                        Text(category)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle(category == selectedCategory ? Color(uiColor: .textColorBW) : Color(UIColor.label))
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background {
                                Capsule()
                                    .stroke(Color(UIColor.label))
                                    .fill(category == selectedCategory ? Color(uiColor: .fillColorWB) : .clear)
                            }
                    })
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
    }

    @ViewBuilder
    func dummyThumbnails() -> some View {
        VStack {
            ForEach(1...10, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.gray)
                    .frame(height: 120)
            }
        }
        .padding()
    }
}

#Preview {
    HomeScreen()
}
