//
//  HomeScreen.swift
//  NewsLetters
//
//  Created by Gokul P on 1/7/25.
//

import SwiftUI

struct HomeScreen: View {

    @State var viewModel = ViewModel()

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
                if viewModel.isSearchActive {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .fontWeight(.semibold)
                        TextField("Search", text: $viewModel.searchText)
                            .padding(6) // Add padding inside the text field
                            .cornerRadius(8) // Apply corner radius
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(UIColor.label), lineWidth: 2)
                            )
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                viewModel.isSearchActive = false
                                viewModel.searchText = ""
                                viewModel.filterNewsItems()
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(UIColor.label))
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                } else {
                    Text("Newsletters")
                        .font(.system(size: 30, weight: .bold))
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    Spacer()
                    HStack(spacing: 18) {
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                viewModel.isSearchActive = true
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
            .transition(.opacity)
        }
        .padding(.top, safeArea().top + 20)
        .background {
            Color.primaryBackGround
                .ignoresSafeArea()
                .shadow(color: Color(UIColor.label).opacity(0.18), radius: 8, x: 0, y: 4)
        }
        .padding(.top, -15)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: viewModel.categories)
    }

    @ViewBuilder
    func newsList() -> some View {
        LazyVStack(spacing: 18) {
            ForEach(viewModel.filteredNewsItems) { item in
                ZStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.heading)
                            .font(.headline)
                            .foregroundColor(Color(uiColor: .label))
                            .lineLimit(2)

                        Text(item.detailedNews)
                            .font(.subheadline)
                            .foregroundColor(Color(uiColor: .label).opacity(0.8))
                            .lineLimit(3)

                        HStack {
                            Text(item.category)
                                .font(.caption)
                                .foregroundColor(Color(uiColor: .label).opacity(0.7))

                            Spacer()

                            Text("\(item.timeToRead) min read")
                                .font(.caption)
                                .foregroundColor(Color(uiColor: .label).opacity(0.7))
                        }
                    }
                    .padding()
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(UIColor.label), lineWidth: 2)
                )
            }
        }
        .padding()
    }

}

#Preview {
    HomeScreen()
}
