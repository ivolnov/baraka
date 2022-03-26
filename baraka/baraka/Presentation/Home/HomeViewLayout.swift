//
//  HomeViewLayout.swift
//  baraka
//
//  Created by Ivan Volnov on 26.03.2022.
//

import UIKit

final class HomeViewLayout: UICollectionViewCompositionalLayout {
    
    init() {
        
        super.init { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch sectionIndex {
                
            case 0:
                
                let leadingItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                      heightDimension: .fractionalHeight(1.0)))
                leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

                let containerGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                      heightDimension: .fractionalHeight(0.3)),
                    subitems: [leadingItem])
                let section = NSCollectionLayoutSection(group: containerGroup)
                section.orthogonalScrollingBehavior = .continuous

                let headerFooterSize = NSCollectionLayoutSize(
                  widthDimension: .fractionalWidth(1.0),
                  heightDimension: .estimated(20)
                )
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                  layoutSize: headerFooterSize,
                  elementKind: UICollectionView.elementKindSectionHeader,
                  alignment: .top
                )
                section.boundarySupplementaryItems = [sectionHeader]
                
                return section
                
            case 1:
                
                let leadingItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0)))
                leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

                let containerGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(0.4)),
                    subitems: [leadingItem])
                let section = NSCollectionLayoutSection(group: containerGroup)
                section.orthogonalScrollingBehavior = .paging
                
                
                let headerFooterSize = NSCollectionLayoutSize(
                  widthDimension: .fractionalWidth(1.0),
                  heightDimension: .estimated(20)
                )
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                  layoutSize: headerFooterSize,
                  elementKind: UICollectionView.elementKindSectionHeader,
                  alignment: .top
                )
                section.boundarySupplementaryItems = [sectionHeader]

                return section
                
            default:
                
                let leadingItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalHeight(0.5)))
                leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)


                let containerGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalHeight(1.0)),
                    subitems: [leadingItem])
                let section = NSCollectionLayoutSection(group: containerGroup)

                
                let headerFooterSize = NSCollectionLayoutSize(
                  widthDimension: .fractionalWidth(1.0),
                  heightDimension: .estimated(20)
                )
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                  layoutSize: headerFooterSize,
                  elementKind: UICollectionView.elementKindSectionHeader,
                  alignment: .top
                )
                section.boundarySupplementaryItems = [sectionHeader]
                
                return section
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
