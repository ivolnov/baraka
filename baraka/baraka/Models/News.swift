//
//  News.swift
//  baraka
//
//  Created by Ivan Volnov on 25.03.2022.
//

import Foundation

// MARK: - News

struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article

struct Article: Codable {
    let author, title: String?
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
    let content: String
}
