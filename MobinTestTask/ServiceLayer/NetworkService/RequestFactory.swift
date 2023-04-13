//
//  RequestFactory.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 13.04.2023.
//

import Foundation

struct RequestFactory {    
    struct CompanyRequest {
        static func modelConfig(urlRequest: URLRequest) -> RequestConfig<CompanyParser> {
            let request = CompanyUrlRequest(urlRequest: urlRequest)
            let parser = CompanyParser()
            return RequestConfig<CompanyParser>(request: request, parser: parser)
        }
    }
}
