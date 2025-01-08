//
//  NewsItem.swift
//  NewsLetters
//
//  Created by Gokul P on 1/8/25.
//

import Foundation

struct NewsItem: Codable {
    let category: String
    let detailedNews: String
    let heading: String
    let link: String
    let timeToRead: Int

    enum CodingKeys: String, CodingKey {
        case category
        case detailedNews = "detailed_news"
        case heading
        case link
        case timeToRead = "time_to_read"
    }
}

// MARK: - Identifiable

extension NewsItem: Identifiable {
    var id: String {
        category + heading
    }
}

// MARK: - Hashable

extension NewsItem: Hashable {}
