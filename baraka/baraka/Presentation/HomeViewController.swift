//
//  HomeViewController.swift
//  baraka
//
//  Created by Ivan Volnov on 25.03.2022.
//

import Foundation
import Combine
import UIKit

enum Section {
    case tickers
    case articles
    case articleCards
}

enum Cell {
    case ticker(Ticker)
    case article(Article)
    case articleCard(Article)
}

extension Cell: Hashable {
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case let .article(model), let .articleCard(model):
            hasher.combine(model.id)
        case let .ticker(model):
            hasher.combine(model.id)
        }
    }
    
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        switch (lhs, rhs) {
        case  (let .article(lhsModel), let .article(rhsModel)):
            return lhsModel.id == rhsModel.id
        case (let .articleCard(lhsModel), let .articleCard(rhsModel)):
            return lhsModel.id == rhsModel.id
        case (let .ticker(lhsModel), let .ticker(rhsModel)):
            return lhsModel.id == rhsModel.id
        default:
            return false
        }
    }
}
    

fileprivate typealias DataSource = UICollectionViewDiffableDataSource<Section, Cell>
fileprivate typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Cell>

class HomeViewController: UIViewController {
    
    private let tickerService = TickerServiceImpl()
    private let newsService = NewsServiceeImpl()
    private var bag: Set<AnyCancellable> = []
    
    private lazy var dataSource = makeDataSource()
    
    private var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        loadData()
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TickerCell.self, forCellWithReuseIdentifier: TickerCell.reuseIdentifier)
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.reuseIdentifier)
        collectionView.register(ArticleCardCell.self, forCellWithReuseIdentifier: ArticleCardCell.reuseIdentifier)
        collectionView.register(
            HomeSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier
        )
        
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func loadData() {
        newsService
            .articles()
            .combineLatest(tickerService.tickers())
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { articles, tickers in self.update(tickers: tickers, articles: articles)}
            )
            .store(in: &bag)
    }
    
    private func update(tickers: [Ticker], articles: [Article]) {
        
        var snapshot = Snapshot()
        
        let articleCardsCells = articles[0..<6].map { article in Cell.articleCard(article) }
        let articlesCells = articles[6...].map { article in Cell.article(article) }
        let tickerCells = tickers.map { ticker in Cell.ticker(ticker) }
        
        snapshot.appendSections([.tickers, .articleCards, .articles])
        snapshot.appendItems(tickerCells, toSection: .tickers)
        snapshot.appendItems(articlesCells, toSection: .articles)
        snapshot.appendItems(articleCardsCells, toSection: .articleCards)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func makeDataSource() -> DataSource {
        
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, cell in

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
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier,
                for: indexPath) as? HomeSectionHeaderView
            
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            
            switch section {
            case .articleCards:
                view?.configure(with: "Trending")
            case .tickers:
                view?.configure(with: "Tickers")
            case .articles:
                view?.configure(with: "News")
            }
        
            return view
        }
        
        return dataSource
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
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
        
        return layout
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
