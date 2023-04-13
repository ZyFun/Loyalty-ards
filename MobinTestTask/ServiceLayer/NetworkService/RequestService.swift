//
//  RequestService.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 13.04.2023.
//

import Foundation

protocol IRequest {
    var urlRequest: URLRequest? { get }
}

protocol IParser {
    associatedtype Model
    func parse(data: Data) -> Model?
}

protocol IRequestSender {
    func send<Parser>(
        config: RequestConfig<Parser>,
        completionHandler: @escaping (Result<(Parser.Model?, Data?, URLResponse?), NetworkError>) -> Void
    )
}

struct RequestConfig<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser?
}

final class RequestSender: IRequestSender {
    func send<Parser>(
        config: RequestConfig<Parser>,
        completionHandler: @escaping (Result<(Parser.Model?, Data?, URLResponse?), NetworkError>) -> Void
    ) where Parser: IParser {
        guard let urlRequest = config.request.urlRequest else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        // Не использовать в проде
        let delegate = InvalidCertURLSessionDelegate()
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.urlCache = nil
        sessionConfig.timeoutIntervalForRequest = 40.0
        
        let session = URLSession(configuration: sessionConfig, delegate: delegate, delegateQueue: nil)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                SystemLogger.error(error.localizedDescription)
                completionHandler(.failure(.networkError))
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                SystemLogger.error("Ошибка получения кода статуса")
                completionHandler(.failure(.statusCodeError))
                return
            }
            
            if !(200..<300).contains(statusCode) {
                switch statusCode {
                case 400:
                    let serverMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                    completionHandler(.failure(.messageError(serverMessage)))
                case 401:
                    completionHandler(.failure(.authError))
                case 500...:
                    completionHandler(.failure(.serverUnavailable))
                default:
                    SystemLogger.error(statusCode.description)
                    completionHandler(.failure(.unownedError))
                }
            }
            
            #warning("Удалить перед отправкой")
            if let data = data, let jsonString = String(data: data, encoding: .utf8) {
                print("Response JSON: \(jsonString)")
            }
            
            if let data = data,
               let parseModel: Parser.Model = config.parser?.parse(data: data) {
                completionHandler(.success((parseModel, nil, nil)))
            } else if let data = data {
                completionHandler(.success((nil, data, response)))
            } else {
                completionHandler(.failure(.parseError))
            }
        }
        task.resume()
    }
}
