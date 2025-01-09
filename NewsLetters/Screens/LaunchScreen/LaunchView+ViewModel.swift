//
//  LaunchView+ViewModel.swift
//  NewsLetters
//
//  Created by Gokul P on 1/9/25.
//

import Foundation
import Observation

extension LaunchView {
    
    @MainActor
    @Observable
    class ViewModel {
        
        private let newsRepository: NewsRepositoryProtocol
        var isLoading = true
        
        init(newsRepository: NewsRepositoryProtocol = NewsRepository()) {
            self.newsRepository = newsRepository
        }
        
        func cacheLatestNewsItems() async {
            do {
                async let getCategories = newsRepository.getCategoriesOfNews(on: .now)
                async let getNews = newsRepository.getNewsItems(on: .now)
                async let minTime: () = Task.sleep(for: .seconds(2))
                try await (_, _, _) = (getCategories, getNews, minTime)
                isLoading = false
            } catch {
                print("Error getting the feed from Firebase")
            }
        }
    }
}
