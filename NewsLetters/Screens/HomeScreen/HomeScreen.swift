//
//  HomeScreen.swift
//  NewsLetters
//
//  Created by Gokul P on 1/7/25.
//

import SwiftUI

struct HomeScreen: View {

    @State var viewModel = ViewModel()
    @State private var isSearchActive = false
    @State private var searchText = ""

    var body: some View {
        ZStack {
            AutoHidingHeaderView(content: {
                newsList()
            }, header: {
                customHeader()
            })
            loadingIndicator
        }
        .onChange(of: viewModel.selectedDate) {
            viewModel.updateCategoriesAnNewsItems()
        }
        .onChange(of: viewModel.selectedCategory) {
            viewModel.filterNewsItems()
        }
    }
}

extension HomeScreen {

    var loadingIndicator: some View {
        VStack {
            Image(
                systemName: viewModel.categories.isEmpty && !viewModel.showProgressIndicator
                    ? "exclamationmark.octagon.fill"
                    : "text.page.badge.magnifyingglass"
            )
            .symbolEffect(.disappear, isActive: !viewModel.showProgressIndicator && !viewModel.categories.isEmpty)
            .symbolEffect(.bounce.up.byLayer, isActive: viewModel.showProgressIndicator)
            .font(.system(size: 60))
            Text("No Newsletters found for the date")
                .opacity(viewModel.categories.isEmpty && !viewModel.showProgressIndicator ? 1 : 0)
                .bold()
                .font(.system(size: 20))
        }
    }

    @ViewBuilder
    func customHeader() -> some View {
        VStack(spacing: 10) {
            HStack {
                if isSearchActive {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                isSearchActive = false
                                searchText = ""
                                viewModel.filterNewsItems()
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                } else {
                    Text("Today")
                        .font(.system(size: 30, weight: .bold))
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    Spacer()
                    HStack(spacing: 18) {
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                isSearchActive = true
                            }
                        }, label: {
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
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            .frame(height: 30)
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
