//
//  HomeViewLayout.swift
//  baraka
//
//  Created by Ivan Volnov on 26.03.2022.
//

import UIKit

final class HomeViewLayout: UICollectionViewCompositionalLayout {
    
    init(sectionBuilder: HomeViewLayoutSectionBuilder) {
        
        super.init { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return sectionBuilder.buildTickersSection()
            case 1:
                return sectionBuilder.buildArticleCardsSection()
            default:
                return sectionBuilder.buildArticlesSection()
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
