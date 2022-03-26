//
//  ArticleCardCell.swift
//  baraka
//
//  Created by Ivan Volnov on 26.03.2022.
//

import UIKit

import Kingfisher

final class ArticleCardCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ArtiicleCardCell"
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        title.text = model.title
        image.kf.setImage(with: URL(string: model.urlToImage))
    }
    
    private func setUp() {
        
        addSubview(title)
        addSubview(image)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            image.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
