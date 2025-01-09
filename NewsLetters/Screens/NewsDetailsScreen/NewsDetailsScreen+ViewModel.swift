//
//  NewsDetailsScreen+ViewModel.swift
//  NewsLetters
//
//  Created by Gokul P on 1/9/25.
//

import Foundation
import Observation

extension NewsDetailsScreen {
    
    @Observable
    class ViewModel {
        
        let newsItem: NewsItem
        let relatedNewsItems: [NewsItem]
        
        init(newsItem: NewsItem, relatedNewsItems: [NewsItem]) {
            self.newsItem = newsItem
            self.relatedNewsItems = relatedNewsItems
        }
        
        func getRelatedNewsItems() -> [NewsItem] {
            return relatedNewsItems.filter { $0.id != newsItem.id }
        }
    }
}
