//
//  RequestFactory.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 13.04.2023.
//

import Foundation

struct RequestFactory {    
    struct CompanyRequest {
        static func modelConfig(offset: Int) -> RequestConfig<CompanyParser> {
            let request = CompanyUrlRequest(offset: offset)
            let parser = CompanyParser()
            return RequestConfig<CompanyParser>(request: request, parser: parser)
        }
    }
}
