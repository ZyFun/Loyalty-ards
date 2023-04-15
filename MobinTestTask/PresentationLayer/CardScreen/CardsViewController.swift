//
//  CardsViewController.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 14.04.2023.
//

import UIKit

protocol CardsView: AnyObject {
    func display(models: [CardModel])
    func showAlert(title: String, message: String, isReloadData: Bool)
}

final class CardsViewController: UIViewController {
    // MARK: - Public properties
    
    var presenter: CardsPresentationLogic?
    var dataSourceProvider: ICardsDataSourceProvider?
    
    // MARK: - Private properties
    
    @UsesAutoLayout
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.white
        return view
    }()
    
    @UsesAutoLayout
    private var cardManagementLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.blue
        label.text = "Управление картами"
        label.font = Fonts.systemNormal(.size1).font
        return label
    }()
    
    @UsesAutoLayout
    private var cardsTableView: UITableView = {
        let tableView = UITableView()
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
        
        DispatchQueue.main.async { [weak self] in
            self?.dataSourceProvider?.updateDataSource()
        }
    }
    
    func showAlert(title: String, message: String, isReloadData: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let loadAction = UIAlertAction(title: "Повторить", style: .default) { [weak self]_ in
            self?.presenter?.getServerData(offset: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { [weak self] _ in
            // TODO: код остановки кастомного активити индикатора
            // Нужно его добавить
        }
        
        if isReloadData {
            alert.addAction(loadAction)
        }
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
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
        
        cardsTableView.separatorStyle = .none
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
        containerView.addSubview(cardManagementLabel)
        
        NSLayoutConstraint.activate([
            cardManagementLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            cardManagementLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Indents.red),
            cardManagementLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Indents.red),
            
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            containerView.bottomAnchor.constraint(equalTo: cardsTableView.topAnchor),
            
            cardsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
