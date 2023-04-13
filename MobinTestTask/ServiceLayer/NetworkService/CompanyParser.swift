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

struct CompanyUrlRequest: IRequest {
    var urlRequest: URLRequest?
    var requestInfo = CompanyRequestModel()
    
    init(offset: Int) {
        requestInfo.updateOffset(offset)
        self.urlRequest = request()
    }
    
    mutating func request() -> URLRequest? {
        guard let url = URL(string: requestInfo.url) else {
            SystemLogger.error("Неправильный URL")
            return nil
        }
        
        var urlRequest = URLRequest(url: url, timeoutInterval: 30)
        urlRequest.httpMethod = requestInfo.method
        
        let header = requestInfo.header
        urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
    
        let requestBodyRaw = requestInfo.body
        urlRequest.httpBody = requestBodyRaw.data(using: .utf8)
        
        return urlRequest
    }
}
