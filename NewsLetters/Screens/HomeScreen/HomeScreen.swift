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
        .task {
            let newsRepo = NewsRepository()
            do {
                try await newsRepo.getCategoriesOfNews(on: .now)
            } catch {
                print("Error on getting categories")
            }
        }
    }
}

extension HomeScreen {
    @ViewBuilder
    func customHeader() -> some View {
        VStack(spacing: 10) {
            HStack {
                Text("Today")
                    .font(.system(size: 30, weight: .bold))
                Spacer()
                HStack(spacing: 18) {
                    Button(action: {}, label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .fontWeight(.semibold)
                    })
                    .buttonStyle(.plain)
                    Button(action: {}, label: {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .fontWeight(.semibold)
                    })
                    .buttonStyle(.plain)
                }
            }
            HorizontalDatePicker(selectedDate: $selectedDate)
            CategorySelectorView(
                items: categories,
                selectedItem: $selectedCategory,
                itemTitle: { $0 }
            )
        }
        .padding(.horizontal)
        .padding(.top, safeArea().top + 20)
        .background {
            Color.primaryBackGround
                .ignoresSafeArea()
        }
        .padding(.top, -15)
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
