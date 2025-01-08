//
//  NewsRepository.swift
//  NewsLetters
//
//  Created by Gokul P on 1/7/25.
//

import FirebaseCore
import FirebaseFirestore
import Foundation

class NewsRepository: NewsRepositoryProtocol {

    let db = Firestore.firestore()
    let dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }

    func getCategoriesOfNews(on date: Date) async throws -> [String] {
        let dateString = dateFormatter.string(from: date)
        let newsCollection = db.collection("news")

        let docRef = newsCollection.document(dateString)
        let cachedDocSnapshot = try await docRef.getDocument(source: .cache)

        if let data = cachedDocSnapshot.data(), let categories = data["categories"] as? [String] {
            return categories
        }

        let docSnapshot = try await docRef.getDocument(source: .server)

        if let data = docSnapshot.data(), let categories = data["categories"] as? [String] {
            return categories
        }

        return []
    }

    func getNewsItems(on date: Date) async throws -> [NewsItem] {
        let dateString = dateFormatter.string(from: date)
        let newsCollection = db.collection("news")
        let cachedQuerySnapshot = try await newsCollection.document(dateString).collection("newsItems")
            .getDocuments(source: .cache)
        if !cachedQuerySnapshot.documents.isEmpty {
            var newsItems: [NewsItem] = []
            for document in cachedQuerySnapshot.documents {
                let newsItem = try document.data(as: NewsItem.self)
                newsItems.append(newsItem)
            }
            return newsItems
        }
        let querySnapshot = try await newsCollection.document(dateString).collection("newsItems")
            .getDocuments(source: .server)
        var newsItems: [NewsItem] = []
        for document in querySnapshot.documents {
            let newsItem = try document.data(as: NewsItem.self)
            newsItems.append(newsItem)
        }
        return newsItems
    }
}
