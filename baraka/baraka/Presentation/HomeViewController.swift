//
//  HomeViewController.swift
//  baraka
//
//  Created by Ivan Volnov on 25.03.2022.
//

import Foundation
import Combine
import UIKit


fileprivate let text = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mauris rhoncus aenean vel elit. Platea dictumst quisque sagittis purus sit amet. Risus quis varius quam quisque. Venenatis cras sed felis eget velit aliquet sagittis id. Massa ultricies mi quis hendrerit dolor magna eget. Eget mi proin sed libero. Gravida rutrum quisque non tellus. Elit sed vulputate mi sit amet mauris commodo quis. Neque sodales ut etiam sit amet nisl purus in mollis. Est sit amet facilisis magna etiam tempor orci. Nulla porttitor massa id neque aliquam vestibulum. Urna condimentum mattis pellentesque id nibh tortor id aliquet lectus. In arcu cursus euismod quis viverra nibh cras. Id donec ultrices tincidunt arcu non sodales neque sodales ut. Ullamcorper eget nulla facilisi etiam dignissim diam. Neque gravida in fermentum et sollicitudin. Nec feugiat in fermentum posuere urna nec tincidunt praesent semper. Congue mauris rhoncus aenean vel elit scelerisque mauris. In egestas erat imperdiet sed euismod nisi porta.
"""

fileprivate var url: String {  "https://picsum.photos/200/300?random=\(Int.random(in: 0...100))"  }

extension UIColor {
    class var random: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}

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
            hasher.combine(model.urlToImage)
            hasher.combine(model.title)
        case let .ticker(model):
            hasher.combine(model.symbol)
            hasher.combine(model.price)
        }
    }
    
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        switch (lhs, rhs) {
        case  (let .article(lhsModel), let .article(rhsModel)):
            return lhsModel.urlToImage == rhsModel.urlToImage && lhsModel.title == rhsModel.title
        case (let .articleCard(lhsModel), let .articleCard(rhsModel)):
            return lhsModel.urlToImage == rhsModel.urlToImage && lhsModel.title == rhsModel.title
        case (let .ticker(lhsModel), let .ticker(rhsModel)):
            return lhsModel.price == rhsModel.price && lhsModel.symbol == rhsModel.symbol
        default:
            return false
        }
    }
}
    

fileprivate typealias DataSource = UICollectionViewDiffableDataSource<Section, Cell>
fileprivate typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Cell>

class HomeViewController: UIViewController {

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
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func loadData() {
        
        
        let tickers: [Cell] = [
            .ticker(Ticker(symbol: "AAPL", price: 243)),
            .ticker(Ticker(symbol: "TSLA", price: 1023)),
            .ticker(Ticker(symbol: "AMZN", price: 3102)),
            .ticker(Ticker(symbol: "META", price: 702)),
        ]
        
        let articleCards: [Cell] = [
            .articleCard(Article(author: "Ivan Volnov",
                                 title: "How to move to dubai",
                                 description: "Interesting story",
                                 url: "",
                                 urlToImage: url,
                                 publishedAt: Date(),
                                 content: text)),
            .articleCard(Article(author: "Brad Pitt",
                                 title: "How to move to dubai part 2",
                                 description: "Interesting story",
                                 url: "",
                                 urlToImage: url,
                                 publishedAt: Date(),
                                 content: text)),
            .articleCard(Article(author: "Johnny Depp",
                                 title: "How to move to dubai and never work",
                                 description: "Interesting story",
                                 url: "",
                                 urlToImage: url,
                                 publishedAt: Date(),
                                 content: text)),
            .articleCard(Article(author: "Apolonia Lapiedra",
                                 title: "How to move to dubai and get involved with escort",
                                 description: "Interesting story",
                                 url: "",
                                 urlToImage: url,
                                 publishedAt: Date(),
                                 content: text)),
            .articleCard(Article(author: "Pierre Woodman",
                                 title: "How to move to dubai as soon as possible",
                                 description: "Interesting story",
                                 url: "",
                                 urlToImage: url,
                                 publishedAt: Date(),
                                 content: text)),
            .articleCard(Article(author: "Jimmi Hedrix",
                                 title: "How to move to dubai and not to make a complex assignment",
                                 description: "Interesting story",
                                 url: "",
                                 urlToImage: url,
                                 publishedAt: Date(),
                                 content: text)),
        ]
        
        let articles: [Cell] = [
            .article(Article(author: "Ivan Volnov",
                             title: "How to move to dubai",
                             description: text,
                             url: "",
                             urlToImage: url,
                             publishedAt: Date(),
                             content: text)),
            .article(Article(author: "Brad Pitt",
                             title: "How to move to dubai part 2",
                             description: text,
                             url: "",
                             urlToImage: url,
                             publishedAt: Date(),
                             content: text)),
            .article(Article(author: "Johnny Depp",
                             title: "How to move to dubai and never work",
                             description: text,
                             url: "",
                             urlToImage: url,
                             publishedAt: Date(),
                             content: text)),
            .article(Article(author: "Apolonia Lapiedra",
                             title: "How to move to dubai and get involved with escort",
                             description: text,
                             url: "",
                             urlToImage: url,
                             publishedAt: Date(),
                             content: text)),
            .article(Article(author: "Pierre Woodman",
                             title: "How to move to dubai as soon as possible",
                             description: text,
                             url: "",
                             urlToImage: url,
                             publishedAt: Date(),
                             content: text)),
            .article(Article(author: "Jimmi Hedrix",
                             title: "How to move to dubai and not to make a complex assignment",
                             description: text,
                             url: "",
                             urlToImage: url,
                             publishedAt: Date(),
                             content: text)),
        ]
        
        var snapshot = Snapshot()
        
        snapshot.appendSections([.tickers, .articleCards, .articles])
        snapshot.appendItems(articleCards, toSection: .articleCards)
        snapshot.appendItems(articles, toSection: .articles)
        snapshot.appendItems(tickers, toSection: .tickers)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func makeDataSource() -> DataSource {
        
        DataSource(collectionView: collectionView) { collectionView, indexPath, cell in

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
