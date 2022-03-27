//
//  HomeDataSourceBuilder.swift
//  baraka
//
//  Created by Ivan Volnov on 27.03.2022.
//

import Foundation
import UIKit

protocol HomeDataSourceBuilder: AnyObject {
    func build(with collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Section, Cell>
}

final class HomeDataSourceBuilderImpl {}

// MARK: - HomeDataSourceBuilder

extension HomeDataSourceBuilderImpl: HomeDataSourceBuilder {
    
    func build(with collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Section, Cell> {
        HomeDataSource(collectionView: collectionView)
    }
}
