//
//  CardsConfigurator.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 14.04.2023.
//

import UIKit

final class CardsConfigurator {
    let requestService: IRequestSender
    
    init(requestService: IRequestSender) {
        self.requestService = requestService
    }
    
    func config(
        view: UIViewController
    ) {
        guard let view = view as? CardsViewController else { return }
        let presenter = CardsPresenter(view: view)
        let dataSourceProvider: ICardsDataSourceProvider = CardsDataSourceProvider(presenter: presenter)
        
        view.presenter = presenter
        view.dataSourceProvider = dataSourceProvider
        presenter.requestService = requestService
    }
}
