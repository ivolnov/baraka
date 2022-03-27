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
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .tertiaryLabel
        label.textAlignment = .left
        return label
    }()
    
    private lazy var text: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
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
        text.text = model.description
        title.text = model.title
        date.text = model.publishedAt.timeAgoDisplay()
        image.kf.setImage(with: URL(string: model.urlToImage))
    }
    
    private func setUp() {
        
        addSubview(title)
        addSubview(image)
        addSubview(text)
        addSubview(date)
        
        NSLayoutConstraint.activate([
            
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: .margin.small),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .margin.small),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.margin.small),
            
            date.topAnchor.constraint(equalTo: title.bottomAnchor, constant: .margin.small),
            date.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.margin.small),
            date.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .margin.small),
            
            image.topAnchor.constraint(equalTo: date.bottomAnchor, constant: .margin.small),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .margin.small),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.margin.small),
            
            text.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .margin.small),
            text.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.margin.small),
            text.topAnchor.constraint(equalTo: image.bottomAnchor, constant: .margin.small),
            text.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.margin.small)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
