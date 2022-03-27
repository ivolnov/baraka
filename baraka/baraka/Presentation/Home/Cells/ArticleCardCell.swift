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
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = .radius.small
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
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
            
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: .margin.small),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .margin.small),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.margin.small),
            
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: .margin.small),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .margin.small),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.margin.small),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.margin.medium)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
