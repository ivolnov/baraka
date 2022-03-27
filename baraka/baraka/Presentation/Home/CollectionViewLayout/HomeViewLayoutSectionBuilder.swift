//
//  HomeViewLayoutSectionBuilder.swift
//  baraka
//
//  Created by Ivan Volnov on 27.03.2022.
//

import UIKit

protocol HomeViewLayoutSectionBuilder: AnyObject {
    func buildTickersSection() -> NSCollectionLayoutSection
    func buildArticlesSection() -> NSCollectionLayoutSection
    func buildArticleCardsSection() -> NSCollectionLayoutSection
}

final class HomeViewLayoutSectionBuilderImpl {}

// MARK: - HomeViewLayoutSectionBuilder

extension HomeViewLayoutSectionBuilderImpl: HomeViewLayoutSectionBuilder {
    
    func buildTickersSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                               heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = .horizontalSmall
        
        let containerGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.05)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.orthogonalScrollingBehavior = .continuous
        
        section.boundarySupplementaryItems = [buildSectionHeader()]
        
        return section
    }
    
    func buildArticleCardsSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = .horizontalSmall
        
        let containerGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.4)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.orthogonalScrollingBehavior = .paging
        
        section.boundarySupplementaryItems = [buildSectionHeader()]
        
        return section
    }
    
    func buildArticlesSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.5)))
        item.contentInsets = .horizontalSmall
        
        let squareDevices = UIScreen.main.bounds.height / UIScreen.main.bounds.width < 1.8
        
        let containerGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(squareDevices ? 1.2 : 0.9)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: containerGroup)

        section.boundarySupplementaryItems = [buildSectionHeader()]
        
        return section
    }
    
    private func buildSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        let headerFooterSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(20)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        return sectionHeader
    }
}
