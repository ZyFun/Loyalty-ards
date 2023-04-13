//
//  CompanyParser.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 13.04.2023.
//

import Foundation

final class CompanyParser: IParser {
    typealias Model = [CompanyData]
    
    func parse(data: Data) -> Model? {
        var model: Model?
        do {
            model = try JSONDecoder().decode(Model.self, from: data)
        } catch {
            SystemLogger.error(error.localizedDescription)
        }
        return model
    }
}

// TODO: Все настройки вынести сюда. Как изменяемый параметр принимать только offset
struct CompanyUrlRequest: IRequest {
    var urlRequest: URLRequest?
    
    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }
}
