//
//  CardsViewController.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 14.04.2023.
//

import UIKit

protocol CardsView: AnyObject {
    func display(models: [CardModel])
}

final class CardsViewController: UIViewController {
    // MARK: - Public properties
    
    var presenter: CardsPresentationLogic?
    var dataSourceProvider: ICardsDataSourceProvider?
    
    // MARK: - Private properties
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.white
        return view
    }()
    
    private var cardManagementButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blue
        label.text = "Управление картами"
        label.font = Fonts.systemNormal.font
        return label
    }()
    
    private var cardsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.lightGrey
        return tableView
    }()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presenter?.getServerData(offset: 0)
    }
}

// MARK: - Логика обновления данных View

extension CardsViewController: CardsView {
    func display(models: [CardModel]) {
        dataSourceProvider?.cardModels = models
        dataSourceProvider?.updateDataSource()
    }
}

// MARK: - Конфигурирование ViewController

private extension CardsViewController {
    func setup() {
        view.backgroundColor = Colors.white
        
        setupTableView()
        setupConstraints()
    }
    
    func setupTableView() {
        registerElements()
        dataSourceProvider?.makeDataSource(with: cardsTableView)
        cardsTableView.delegate = dataSourceProvider
    }
    
    func registerElements() {
        cardsTableView.register(
            CardCell.self,
            forCellReuseIdentifier: CardCell.identifier
        )
    }
    
    func setupConstraints() {
        view.addSubview(containerView)
        view.addSubview(cardsTableView)
        containerView.addSubview(cardManagementButton)
        
        NSLayoutConstraint.activate([
            cardManagementButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            cardManagementButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Indents.redHeight),
            cardManagementButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Indents.redHeight),
            
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            containerView.bottomAnchor.constraint(equalTo: cardsTableView.topAnchor),
            
            cardsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Alert

private extension CardsViewController {
    func showErrorAlert() {

    }
}
