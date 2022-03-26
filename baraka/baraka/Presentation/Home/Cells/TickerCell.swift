//
//  TickerCell.swift
//  baraka
//
//  Created by Ivan Volnov on 26.03.2022.
//

import UIKit

final class TickerCell: UICollectionViewCell {
    
    static let reuseIdentifier = "TickerCell"
    
    private lazy var symbol: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          setUp()
    }

    func configure(with model: Ticker) {
        symbol.text = model.symbol
        price.text = String(model.price)
    }
    
    private func setUp() {
        
        addSubview(symbol)
        addSubview(price)
        
        NSLayoutConstraint.activate([
            symbol.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            price.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            symbol.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            price.leadingAnchor.constraint(equalTo: symbol.trailingAnchor, constant: 8)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
