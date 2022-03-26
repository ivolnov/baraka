//
//  HomeViewController.swift
//  baraka
//
//  Created by Ivan Volnov on 25.03.2022.
//

import Foundation
import Combine
import UIKit


fileprivate typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Cell>

class HomeViewController: UIViewController {
    
    private lazy var dataSource = HomeDataSource(collectionView: collectionView)
    private lazy var viewModel = HomeViewModel()
    private lazy var layout = HomeViewLayout()
    
    private var bag: Set<AnyCancellable> = []
    
    private var activityIndicator: UIActivityIndicatorView!
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpActivityIndicator()
        bind()
    }
    
    private func setUpCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
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
    
    private func setUpActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func bind() {
        viewModel
            .$snapshot
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { snapshot in self.dataSource.apply(snapshot, animatingDifferences: true) }
            )
            .store(in: &bag)
        
        viewModel
            .$loading
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: setActivityIndicator
            )
            .store(in: &bag)
    }
    
    private func setActivityIndicator(visible: Bool) {
        switch visible {
        case true:
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
        case false:
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
