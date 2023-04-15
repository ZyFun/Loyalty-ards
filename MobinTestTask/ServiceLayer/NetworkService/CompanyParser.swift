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
    
    let url: URL = URLProvider.getAllCardsUrl()
    let method: HttpMethod = .post
    var header: Header {
        return Header(key: "TOKEN", value: "123")
    }
    var body: String {
        return "{\n\t\"offset\": \(offset)\n}"
    }
    
    private var offset = 0
    
    init(offset: Int) {
        updateOffset(offset)
        self.urlRequest = request()
    }
    
    mutating func updateOffset(_ newOffset: Int) {
        offset = newOffset
    }
    
    mutating func request() -> URLRequest? {
        var urlRequest = URLRequest(url: url, timeoutInterval: 30)
        urlRequest.httpMethod = method.name
        urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        
        let requestBodyRaw = body
        urlRequest.httpBody = requestBodyRaw.data(using: .utf8)
        
        return urlRequest
    }
}

extension CompanyUrlRequest {
    struct Header {
        let key: String
        let value: String
    }
}

enum HttpMethod: Equatable {
    case post
    
    var name: String {
        switch self {
        case .post: return "POST"
        }
    }
}

struct CompanyImageUrlRequest: IRequest {
    var urlRequest: URLRequest?
    var urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
        urlRequest = request(stringURL: urlString)
    }
    
    mutating func request(stringURL: String) -> URLRequest? {
        if let url = URL(string: stringURL) {
            urlRequest = URLRequest(url: url, timeoutInterval: 30)
        } else {
            SystemLogger.error("Неправильный URL")
        }
        return urlRequest
    }
}
