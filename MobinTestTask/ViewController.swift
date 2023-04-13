//
//  ViewController.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 13.04.2023.
//

import UIKit

class ViewController: UIViewController {
    var companyAPIModel: [CompanyData] = []
    var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getServerData()
    }
    
    func getServerData() {
        let requestService = ServiceAssembly().requestService
        let requestConfig = RequestFactory.CompanyRequest.modelConfig(offset: offset)
        requestService.send(config: requestConfig) { [weak self] result in
            switch result {
            case .success(let(models, _, _)):
                models?.forEach({ model in
                    self?.companyAPIModel.append(model)
                    SystemLogger.info(model.mobileAppDashboard.companyName)
                })
            case .failure(let error):
                SystemLogger.error(error.describing)
            }
        }
    }
}
