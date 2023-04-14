//
//  PresentationAssembly.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 14.04.2023.
//

final class PresentationAssembly {
    private let serviceAssembly = ServiceAssembly()
    
    private let requestService: IRequestSender
    
    init() {
        requestService = serviceAssembly.requestService
    }
    
    lazy var cards: CardsConfigurator = {
        return CardsConfigurator(requestService: requestService)
    }()
}
