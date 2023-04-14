//
//  CardsPresenter.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 14.04.2023.
//

import Foundation

protocol CardsPresentationLogic: AnyObject {
    init(view: CardsView)
    func getServerData(offset: Int)
}

final class CardsPresenter {
    // MARK: - Public Properties
    
    weak var view: CardsView?
    var requestService: IRequestSender?
    
    // MARK: - Private Properties
    
    private var companyAPIModel: [CompanyData] = []
    private var viewModels: [CardModel] = []
    
    // MARK: - Initializer
    
    required init(view: CardsView) {
        self.view = view
    }
    
    // MARK: - Private Methods
    
    private func parseServerDataToViewModel() {
        companyAPIModel.forEach { companyData in
            let model = CardModel(id: companyData.company.companyId)
            viewModels.append(model)
        }
    }
    
    private func presentCards() {
        view?.display(models: viewModels)
    }
}

// MARK: - Presentation Logic

extension CardsPresenter: CardsPresentationLogic {
    func getServerData(offset: Int) {
        let requestConfig = RequestFactory.CompanyRequest.modelConfig(offset: offset)
        requestService?.send(config: requestConfig) { [weak self] result in
            switch result {
            case .success(let(models, _, _)):
                models?.forEach({ model in
                    self?.companyAPIModel.append(model)
                    SystemLogger.info(model.mobileAppDashboard.companyName)
                })
                
                self?.parseServerDataToViewModel()
                self?.presentCards()
            case .failure(let error):
                // TODO: Вывести ошибку на алерт если такая есть
                SystemLogger.error(error.describing)
            }
        }
    }
}
