//
//  CompanyRequestModel.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 13.04.2023.
//

import Foundation

struct CompanyRequestModel {
    let method = "POST"
    var header: Header {
        return Header(key: "TOKEN", value: "123")
    }
    var body: String {
        return "{\n\t\"offset\": \(offset)\n}"
    }
    let url = "http://dev.bonusmoney.pro/mobileapp/getAllCompanies"
    
    private var offset = 0
    
    mutating func updateOffset(_ newOffset: Int) {
        offset = newOffset
    }
}

extension CompanyRequestModel {
    struct Header {
        let key: String
        let value: String
    }
}
