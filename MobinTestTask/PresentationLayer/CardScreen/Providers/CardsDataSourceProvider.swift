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
    
    // TODO: поправить код этот был для тестов
    private var dataSource: UITableViewDiffableDataSource<Section, CardModel>?
    private var infiniteScrollModel: [CardModel] = []
    
    private var countModels = 5
    private func getNewModels() {
        countModels += 5
        infiniteScrollModel.append(contentsOf: cardModels.prefix(countModels))
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
            cellProvider: { tableView, indexPath, model -> UITableViewCell? in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: CardCell.identifier,
                    for: indexPath
                ) as? CardCell else {
                    return UITableViewCell()
                }
                
                cell.config(
                    companyName: model.name,
                    imageUrl: model.imageUrl,
                    mark: model.mark,
                    percent: model.percent,
                    loyaltyName: model.loyaltyName,
                    hexColors: model.hexColors
                )
                
                return cell
            }
        )
    }
    
    func updateDataSource() {
        infiniteScrollModel = Array(cardModels.prefix(countModels))
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, CardModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(infiniteScrollModel, toSection: .main)
        
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
        if indexPath.row == infiniteScrollModel.count - 2 {
            getNewModels()
        }
    }
}
