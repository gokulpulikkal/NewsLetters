//
//  HomeScreen.swift
//  NewsLetters
//
//  Created by Gokul P on 1/7/25.
//

import SwiftUI

struct HomeScreen: View {

    @State
    var viewModel = ViewModel()

    var body: some View {
        AutoHidingHeaderView(content: {
            newsList()
        }, header: {
            customHeader()
        })
        .onChange(of: viewModel.selectedDate) {
            viewModel.updateCategoriesAnNewsItems()
        }
        .onChange(of: viewModel.selectedCategory) {
            viewModel.filterNewsItems()
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
            .padding(.horizontal)
            HorizontalDatePicker(selectedDate: $viewModel.selectedDate)
            CategorySelectorView(
                items: viewModel.categories,
                selectedItem: $viewModel.selectedCategory,
                itemTitle: { $0 }
            )
            .padding(.bottom, 9)
        }
        .padding(.top, safeArea().top + 20)
        .background {
            Color.primaryBackGround
                .ignoresSafeArea()
        }
        .padding(.top, -15)
    }

    @ViewBuilder
    func newsList() -> some View {
        LazyVStack {
            ForEach(viewModel.filteredNewsItems) { item in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color(uiColor: .fillColorWB))
                        .frame(height: 140)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.heading)
                            .font(.headline)
                            .foregroundColor(Color(uiColor: .textColorBW))
                            .lineLimit(2)

                        Text(item.detailedNews)
                            .font(.subheadline)
                            .foregroundColor(Color(uiColor: .textColorBW).opacity(0.8))
                            .lineLimit(2)

                        HStack {
                            Text(item.category)
                                .font(.caption)
                                .foregroundColor(Color(uiColor: .textColorBW).opacity(0.7))

                            Spacer()

                            Text("\(item.timeToRead) min read")
                                .font(.caption)
                                .foregroundColor(Color(uiColor: .textColorBW).opacity(0.7))
                        }
                    }
                    .padding()
                }
            }
        }
        .padding()
    }

}

#Preview {
    HomeScreen()
}
