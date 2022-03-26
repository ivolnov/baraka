//
//  ArticleCell.swift
//  baraka
//
//  Created by Ivan Volnov on 26.03.2022.
//

import UIKit
import Kingfisher

final class ArticleCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ArticleCell"
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var text: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          setUp()
    }

    func configure(with model: Article) {
        text.text = model.description
        title.text = model.title
        date.text = model.publishedAt.ISO8601Format()
        image.kf.setImage(with: URL(string: model.urlToImage))
    }
    
    private func setUp() {
        
        addSubview(title)
        addSubview(date)
        addSubview(image)
        addSubview(text)
        
        NSLayoutConstraint.activate([
            
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            date.bottomAnchor.constraint(equalTo: title.bottomAnchor),
            date.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            date.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 8),
            image.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            text.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            text.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            text.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            text.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
