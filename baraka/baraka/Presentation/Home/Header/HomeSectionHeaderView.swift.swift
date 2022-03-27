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
