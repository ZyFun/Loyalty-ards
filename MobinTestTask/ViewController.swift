//
//  ViewController.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 13.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var requestModels: [RequestModel] = []
    var companyAPIModel: [CompanyData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    func getData() {
        let requestModel = getRequestModel()
        let urlRequests = createUrlRequests(requestProvider: requestModel)
        
        if let urlRequest = urlRequests.first {
            getServerData(urlRequest: urlRequest)
        } else {
            SystemLogger.error("Не удалось получить urlRequest")
        }
    }
    
    // TODO: получение данных таким образом не нужно.
    // нужно просто взять руками данные из файла и делать с помощью них запрос
    // со смещением по количеству загруженных объектов
    func getRequestModel() -> [RequestModel] {
        let url = URLProvider.fetchRequestJSONUrl()
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let postmanCollection = try decoder.decode(PostmanCollection.self, from: data)
            
            postmanCollection.item.forEach { item in
                guard let url = URL(string: item.request.url) else {
                    fatalError("Unable to create URL from string: \(item.request.url)")
                }
                
                let model = RequestModel(
                    method: item.request.method,
                    header: item.request.header,
                    body: item.request.body,
                    url: url
                )
                
                requestModels.append(model)
            }
        } catch {
            fatalError("Unable to decode JSON: \(error)")
        }
        
        return requestModels
    }
    
    func createUrlRequests(requestProvider: [RequestModel]) -> [URLRequest] {
        var urlRequests: [URLRequest] = []
        
        requestProvider.forEach { info in
            var urlRequest = URLRequest(url: info.url)
            urlRequest.httpMethod = info.method
            
            for header in info.header {
                urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
            }
            
            // TODO: Переписать
            // данные которые сюда получаем должны быть динамическими со смещением
            // по количеству загруженных объектов
            let requestBodyRaw = info.body.raw
            urlRequest.httpBody = requestBodyRaw.data(using: .utf8)
            
            urlRequests.append(urlRequest)
        }
        
        return urlRequests
    }
    
    func getServerData(urlRequest: URLRequest) {
        let requestService = ServiceAssembly().requestService
        let requestConfig = RequestFactory.CompanyRequest.modelConfig(urlRequest: urlRequest)
        requestService.send(config: requestConfig) { [weak self] result in
            guard let self else { return }
            
            switch result {
                
            case .success(let(models, _, _)):
                models?.forEach({ model in
                    self.companyAPIModel.append(model)
                    print(model.mobileAppDashboard.companyName)
                })
            case .failure(let error):
                SystemLogger.error(error.describing)
            }
        }
    }
}

// MARK: - проверка сертификата
final class InvalidCertURLSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let serverTrust = challenge.protectionSpace.serverTrust!
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
