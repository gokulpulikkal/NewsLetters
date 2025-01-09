//
//  HomeScreen+ViewModel.swift
//  NewsLetters
//
//  Created by Gokul P on 1/8/25.
//

import Foundation
import Observation

extension HomeScreen {

    @MainActor
    @Observable
    class ViewModel {

        let ALL_CATEGORY = "All"

        var categories: [String]
        private var newsItems: [NewsItem]
        var filteredNewsItems: [NewsItem]
        var selectedCategory: String
        var selectedDate: Date
        var showProgressIndicator: Bool = true

        private var prevSelectedDate: Date?

        let newsRepository: NewsRepositoryProtocol

        init(newsRepository: NewsRepositoryProtocol = NewsRepository()) {
            self.categories = []
            self.newsItems = []
            self.filteredNewsItems = []
            self.selectedCategory = ALL_CATEGORY
            self.selectedDate = Date()

            self.newsRepository = newsRepository

            updateCategoriesAnNewsItems()
        }

        func clearNewsData() {
            categories = []
            newsItems = []
            filteredNewsItems = []
            selectedCategory = ""
        }

        func updateCategoriesAnNewsItems() {
            guard prevSelectedDate != selectedDate else {
                return
            }
            prevSelectedDate = selectedDate
            showProgressIndicator = true
            Task {
                await updateCategories()
                if !categories.isEmpty { // no need to try getting news items if categories are empty
                    await updateNewsItems()
                }
                showProgressIndicator = false
            }
        }

        func updateCategories() async {
            do {
                var newCategories = try await newsRepository.getCategoriesOfNews(on: selectedDate)
                if !newCategories.isEmpty {
                    newCategories.insert(ALL_CATEGORY, at: 0)
                    categories = newCategories
                    selectedCategory = categories[0]
                } else {
                    clearNewsData()
                }
            } catch {
                clearNewsData()
                print("Error in getting the categories")
            }
        }

        func updateNewsItems() async {
            do {
                newsItems = try await newsRepository.getNewsItems(on: selectedDate)
            } catch {
                newsItems = []
                print("Error in getting the News Items")
            }
            filteredNewsItems = newsItems
        }

        func filterNewsItems() {
            guard !selectedCategory.isEmpty else {
                return
            }
            if selectedCategory == ALL_CATEGORY {
                filteredNewsItems = newsItems
            } else {
                Task {
                    filteredNewsItems = newsItems.filter { $0.category == selectedCategory }
                }
            }
        }
    }
}
