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
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
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
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .margin.medium),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.margin.medium),
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: .margin.medium),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: .zero)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CGFloat {
    
    enum margin {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
    
    enum radius {
        static let small: CGFloat = 8
    }
    
}

extension NSDirectionalEdgeInsets {
    static let horizontalSmall = NSDirectionalEdgeInsets(top: 0, leading: .margin.small, bottom: 0, trailing: .margin.small)
}
