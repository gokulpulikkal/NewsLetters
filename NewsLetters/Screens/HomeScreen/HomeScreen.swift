//
//  HomeScreen.swift
//  NewsLetters
//
//  Created by Gokul P on 1/7/25.
//

import SwiftUI

struct HomeScreen: View {

    @State var viewModel = ViewModel()
    @State private var vibrateOnRing = false
    @State private var isSettingMenuPresented = false

    var body: some View {
        NavigationStack {
            ZStack {
                AutoHidingHeaderView(content: {
                    NewsListView(newsItems: viewModel.filteredNewsItems)
                        .padding()
                }, header: {
                    customHeader()
                })
                loadingIndicator
            }
            .navigationBarHidden(true)
            .navigationDestination(for: NewsItem.self, destination: { newsItem in
                NewsDetailsScreen(viewModel: NewsDetailsScreen.ViewModel(
                    newsItem: newsItem,
                    relatedNewsItems: viewModel.filteredNewsItems.filter { $0.category == newsItem.category }
                ))
            })
        }
        .tint(Color(uiColor: .primaryAccent))
        .onChange(of: viewModel.selectedDate) {
            viewModel.updateCategoriesAnNewsItems()
        }
        .onChange(of: viewModel.selectedCategory) {
            viewModel.filterNewsItemsWithCategory()
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
            .symbolEffect(.bounce.up.byLayer, isActive: viewModel.showProgressIndicator)
            .font(.system(size: 60))
            Text("No Newsletters found for the date")
                .bold()
                .font(.system(size: 20))
        }
        .opacity(viewModel.categories.isEmpty && !viewModel.showProgressIndicator ? 1 : 0)
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
                            .foregroundStyle(Color(UIColor.primaryAccent))
                        TextField("Search", text: $viewModel.searchText)
                            .padding(6) // Add padding inside the text field
                            .cornerRadius(8) // Apply corner radius
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(UIColor.primaryAccent), lineWidth: 2)
                            )
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                viewModel.isSearchActive = false
                                viewModel.searchText = ""
                                viewModel.filterNewsItemsWithCategory()
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(UIColor.primaryAccent))
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                } else {
                    Text("Newsletters")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(Color(UIColor.primaryAccent))
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
                                .foregroundStyle(Color(UIColor.primaryAccent))
                        })
                        .buttonStyle(.plain)
                        Button(action: {
                            isSettingMenuPresented.toggle()
                        }, label: {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(UIColor.primaryAccent))
                        })
                        .popover(isPresented: $isSettingMenuPresented) {
                            Toggle("", isOn: $vibrateOnRing)
                                .toggleStyle(DarkModeToggleStyle())
                                .scaleEffect(0.8)
                                .padding()
                                .presentationCompactAdaptation(.popover)
                        }
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
                .opacity(
                    viewModel.categories.isEmpty
                        ? 0
                        : 1
                )
        }
        .padding(.top, -15)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: viewModel.categories)
    }
}

#Preview {
    HomeScreen()
}
