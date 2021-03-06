//
//  HomeViewSnapshotBuilder.swift
//  baraka
//
//  Created by Ivan Volnov on 26.03.2022.
//

import UIKit

typealias HomeViewSnapshot = NSDiffableDataSourceSnapshot<Section, Cell>

protocol HomeViewSnapshotBuilder: AnyObject {
    func build(articles: [Article], tickers: [Ticker]) -> HomeViewSnapshot
}

final class HomeViewSnapshotBuilderImpl {
    // Constants
    private let cardsSectionSize = 6
}

// MARK: - HomeViewSnapshotBuilder

extension HomeViewSnapshotBuilderImpl: HomeViewSnapshotBuilder {
    
    func build(articles: [Article], tickers: [Ticker]) -> HomeViewSnapshot {
        
        var snapshot = HomeViewSnapshot()
        
        let articleCardsCells = articles[0..<cardsSectionSize].map { article in Cell.articleCard(article) }
        let articlesCells = articles[cardsSectionSize...].map { article in Cell.article(article) }
        let tickerCells = tickers.map { ticker in Cell.ticker(ticker) }
        
        snapshot.appendSections([.tickers, .articleCards, .articles])
        
        snapshot.appendItems(articleCardsCells, toSection: .articleCards)
        snapshot.appendItems(articlesCells, toSection: .articles)
        snapshot.appendItems(tickerCells, toSection: .tickers)
        
        return snapshot
    }
}
