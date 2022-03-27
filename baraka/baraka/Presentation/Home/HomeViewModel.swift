//
//  HomeViewModel.swift
//  baraka
//
//  Created by Ivan Volnov on 26.03.2022.
//

import Combine

final class HomeViewModel {
    
    private let tickerService = TickerServiceImpl()
    private let newsService = NewsServiceeImpl()
    
    @Published var snapshot: HomeViewSnapshot?
    @Published var loading = true
    
    init() {
        newsService
            .articles()
            .combineLatest(tickerService.tickers())
            .map { articles, tickers in HomeViewSnapshotBuilder().build(articles: articles, tickers: tickers) }
            .replaceError(with: nil)
            .assign(to: &$snapshot)
        
        $snapshot
            .map { $0 == nil }
            .assign(to: &$loading)
    }
}

