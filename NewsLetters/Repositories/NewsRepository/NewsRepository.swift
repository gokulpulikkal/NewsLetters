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

    func getCategoriesOfNews(on date: Date) async throws {
        let newsCollection = db.collection("news")

        let docRef = newsCollection.document("2025-01-08")
        let docSnapshot = try await docRef.getDocument()

        if let data = docSnapshot.data(), let categories = data["categories"] {
            print("categories: \(categories)")
        }
    }

    func getNewsItems(on date: Date, for category: String) async throws {
        print("Needs Implementation")
    }
}
