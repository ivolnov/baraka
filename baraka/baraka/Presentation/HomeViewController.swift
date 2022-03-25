//
//  HomeViewController.swift
//  baraka
//
//  Created by Ivan Volnov on 25.03.2022.
//

import Foundation
import Combine
import UIKit

final class HomeViewController: UIViewController {
    
    private let tickerService = TickerServiceImpl()
    private let newsService = NewsServiceeImpl()
    private var bag: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tickerService
            .tickers()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in }
            )
            .store(in: &bag)
        
        newsService
            .articles()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in }
            )
            .store(in: &bag)
    }
}
