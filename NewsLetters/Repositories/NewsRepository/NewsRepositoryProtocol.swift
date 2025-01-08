//
//  NewsRepositoryProtocol.swift
//  NewsLetters
//
//  Created by Gokul P on 1/7/25.
//

import Foundation

protocol NewsRepositoryProtocol {
    
    func getCategoriesOfNews(on date: Date) async throws
    
    func getNewsItems(on date: Date, for category: String) async throws
}
