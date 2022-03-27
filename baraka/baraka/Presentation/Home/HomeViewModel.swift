//
//  HomeViewModel.swift
//  baraka
//
//  Created by Ivan Volnov on 26.03.2022.
//

import Combine

final class HomeViewModel {
    
    // Dependencies
    private let snapshotBuilder: HomeViewSnapshotBuilder
    private let tickerService: TickerService
    private let newsService: NewsService
    
    @Published var snapshot: HomeViewSnapshot?
    @Published var loading = true
    
    init(newsService: NewsService,
         tickerService: TickerService,
         snapshotBuilder: HomeViewSnapshotBuilder) {
        
        self.snapshotBuilder = snapshotBuilder
        self.tickerService = tickerService
        self.newsService = newsService
        
        newsService
            .articles()
            .combineLatest(tickerService.tickers())
            .map { articles, tickers in self.snapshotBuilder.build(articles: articles, tickers: tickers) }
            .replaceError(with: nil)
            .assign(to: &$snapshot)
        
        $snapshot
            .map { $0 == nil }
            .assign(to: &$loading)
    }
}

