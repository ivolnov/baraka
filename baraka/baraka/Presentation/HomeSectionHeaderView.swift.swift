//
//  HomeSectionHeaderView.swift.swift
//  baraka
//
//  Created by Ivan Volnov on 26.03.2022.
//

import UIKit

final class HomeSectionHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "HomeSectionHeaderView"
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          setUp()
    }

    func configure(with string: String) {
        title.text = string
    }
    
    private func setUp() {
        
        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
