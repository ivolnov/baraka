//
//  Cell.swift
//  baraka
//
//  Created by Ivan Volnov on 26.03.2022.
//

import Foundation

enum Cell {
    case ticker(Ticker)
    case article(Article)
    case articleCard(Article)
}

// MARK: - Hashable

extension Cell: Hashable {
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case let .article(model), let .articleCard(model):
            hasher.combine(model.id)
        case let .ticker(model):
            hasher.combine(model.id)
        }
    }
    
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        switch (lhs, rhs) {
        case  (let .article(lhsModel), let .article(rhsModel)):
            return lhsModel.id == rhsModel.id
        case (let .articleCard(lhsModel), let .articleCard(rhsModel)):
            return lhsModel.id == rhsModel.id
        case (let .ticker(lhsModel), let .ticker(rhsModel)):
            return lhsModel.id == rhsModel.id
        default:
            return false
        }
    }
}
