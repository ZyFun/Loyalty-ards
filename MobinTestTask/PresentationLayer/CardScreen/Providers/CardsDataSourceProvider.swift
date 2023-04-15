//
//  CardDataSourceProvider.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 14.04.2023.
//

import UIKit

protocol ICardsDataSourceProvider: UITableViewDelegate {
    var cardModels: [CardModel] { get set}
    func makeDataSource(with cardsTableView: UITableView)
    func updateDataSource()
}

final class CardsDataSourceProvider: NSObject, ICardsDataSourceProvider {
    
    // MARK: - Public properties
    
    var cardModels: [CardModel] = []
    
    // MARK: - Private properties
    
    private let presenter: CardsPresenter?
    private var dataSource: UITableViewDiffableDataSource<Section, CardModel>?
    /// Свойство для предотвращения попыток загрузки новых данных, если ничего нового загружено не было
    private var loadedCount = 0
    
    // MARK: - Initializer
    
    init(presenter: CardsPresenter) {
        self.presenter = presenter
    }
    
    // MARK: - Private methods
    
    private func getNewModels() {
        if cardModels.count != loadedCount {
            presenter?.getServerData(offset: cardModels.count)
            loadedCount += cardModels.count
        }
    }
}

// MARK: - Table view data source

extension CardsDataSourceProvider {
    enum Section {
        case main
    }
    
    func makeDataSource(with cardsTableView: UITableView) {
        dataSource = UITableViewDiffableDataSource(
            tableView: cardsTableView,
            cellProvider: { [weak self] tableView, indexPath, model -> UITableViewCell? in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: CardCell.identifier,
                    for: indexPath
                ) as? CardCell else {
                    return UITableViewCell()
                }
                
                cell.config(
                    companyId: model.id,
                    companyName: model.name,
                    imageUrl: model.imageUrl,
                    mark: model.mark,
                    percent: model.percent,
                    loyaltyName: model.loyaltyName,
                    hexColors: model.hexColors,
                    delegate: self?.presenter
                )
                
                return cell
            }
        )
    }
    
    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CardModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cardModels, toSection: .main)
        
        dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

// MARK: - Table view delegate

extension CardsDataSourceProvider {
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        if indexPath.row == cardModels.count - 1 {
            getNewModels()
        }
    }
}
