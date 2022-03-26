//
//  HomeDataSource.swift
//  baraka
//
//  Created by Ivan Volnov on 26.03.2022.
//

import UIKit

final class HomeDataSource: UICollectionViewDiffableDataSource<Section, Cell> {
    
    init(collectionView: UICollectionView) {
        
        super.init(collectionView: collectionView) { collectionView, indexPath, cell in
            
            switch cell {
                
            case let .article(model):
                
                guard let cellView = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ArticleCell.reuseIdentifier,
                    for: indexPath) as? ArticleCell
                else {
                    return nil
                }
                
                cellView.configure(with: model)
                
                return cellView
                
            case let .articleCard(model):
                
                guard let cellView = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ArticleCardCell.reuseIdentifier,
                    for: indexPath) as? ArticleCardCell
                else {
                    return nil
                }
                
                cellView.configure(with: model)
                
                return cellView
                
            case let .ticker(model):
                
                guard let cellView = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TickerCell.reuseIdentifier,
                    for: indexPath) as? TickerCell
                else {
                    return nil
                }
                
                cellView.configure(with: model)
                
                return cellView
            }
        }
        
        supplementaryViewProvider = { collectionView, kind, indexPath in
            
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier,
                for: indexPath) as? HomeSectionHeaderView
            
            let section = self.snapshot().sectionIdentifiers[indexPath.section]
            
            view?.configure(with: section.title)
            
            return view
        }
    }
}
