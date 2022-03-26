//
//  Section.swift
//  baraka
//
//  Created by Ivan Volnov on 26.03.2022.
//

import Foundation

enum Section {
    case tickers
    case articles
    case articleCards
}

extension Section {
    var title: String {
        switch self {
        case .articleCards:
            return "Trending"
        case .tickers:
            return "Tickers"
        case .articles:
            return "News"
        }
    }
}
