//
//  Ticker.swift
//  baraka
//
//  Created by Ivan Volnov on 25.03.2022.
//

import Foundation

struct Ticker {
    let id = UUID().uuidString
    let symbol: String
    let price: Double
}
