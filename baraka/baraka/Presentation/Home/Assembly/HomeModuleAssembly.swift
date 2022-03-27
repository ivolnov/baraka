//
//  HomeModuleAssembly.swift
//  baraka
//
//  Created by Ivan Volnov on 27.03.2022.
//

import Foundation
import UIKit

final class HomeModuleAssembly {
    
    func assemble() -> UIViewController {
        
        let session = URLSession.shared
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let tickerService = TickerServiceImpl(session: session)
        let newsService = NewsServiceImpl(session: session, decoder: decoder)
        
        let snapshotBuilder = HomeViewSnapshotBuilderImpl()
        
        let viewModel = HomeViewModel(newsService: newsService,
                                      tickerService: tickerService,
                                      snapshotBuilder: snapshotBuilder)
        
        let sectionBuilder = HomeViewLayoutSectionBuilderImpl()
        let layout = HomeViewLayout(sectionBuilder: sectionBuilder)
        
        let homeDataSourceBuilder = HomeDataSourceBuilderImpl()
        
        return HomeViewController(layout: layout,
                                  viewModel: viewModel,
                                  dataSourceBuilder: homeDataSourceBuilder)
    }
}
