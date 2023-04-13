//
//  ViewController.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 13.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getJsonRequests()
    }
    
    func getJsonRequests() {
        // ПОлучаем json для модели запросов
        guard let url = Bundle.main.url(forResource: "TaskForAppleAppDelelopers.postman_collection", withExtension: "json") else {
            fatalError("Unable to find file in the app bundle")
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let postmanCollection = try decoder.decode(PostmanCollection.self, from: data)
            
            guard let requestInfo = postmanCollection.item.first?.request else {
                fatalError("Unable to find request information")
            }

            guard let url = URL(string: requestInfo.url) else {
                fatalError("Unable to create URL from string: \(requestInfo.url)")
            }

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = requestInfo.method

            for header in requestInfo.header {
                urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
            }

            let requestBodyRaw = requestInfo.body.raw
            urlRequest.httpBody = requestBodyRaw.data(using: .utf8)
            
            // СОздаём делегат и конфигурацию для игнорирования небезопасного сертификата
            let delegate = InvalidCertURLSessionDelegate()
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.urlCache = nil
            sessionConfig.timeoutIntervalForRequest = 30.0
            
            // Делаем запрос на сервер по данным из модели
            let session = URLSession(configuration: sessionConfig, delegate: delegate, delegateQueue: nil)
            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }

                print("Status code: \(httpResponse.statusCode)")
                
                if let data = data, let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                    
                    // Декодируем и парсим json полученный с сервера
                    let decoder = JSONDecoder()
                    guard let data = jsonString.data(using: .utf8) else {
                        print("Invalid decode")
                        return
                    }
                    do {
                        let companyDataArray = try decoder.decode([CompanyData].self, from: data)
                    } catch {
                        print(error)
                    }
                }
            }

            task.resume()
        } catch {
            fatalError("Unable to decode JSON: \(error)")
        }
    }
}

// MARK: - Model

struct PostmanCollection: Codable {
    let info: Info
    let item: [Item]
}

struct Info: Codable {
    let postmanId: String
    let name: String
    let schema: String

    enum CodingKeys: String, CodingKey {
        case postmanId = "_postman_id"
        case name
        case schema
    }
}

struct Item: Codable {
    let name: String
    let request: Request
    let response: [String]
}

struct Request: Codable {
    let method: String
    let header: [Header]
    let body: Body
    let url: String
}

struct Header: Codable {
    let key: String
    let value: String
}

struct Body: Codable {
    let mode: String
    let raw: String
    let options: Options
}

struct Options: Codable {
    let raw: Language
}

struct Language: Codable {
    let language: String
}

// MARK: - проверка сертификата
class InvalidCertURLSessionDelegate: NSObject, URLSessionDelegate {
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

// MARK: server json model
struct Company: Codable {
    let companyId: String
}

struct LoyaltyLevel: Codable {
    let number: Int
    let name: String
    let requiredSum: Int
    let markToCash: Int
    let cashToMark: Int
}

struct CustomerMarkParameters: Codable {
    let loyaltyLevel: LoyaltyLevel
    let mark: Int
}

struct MobileAppDashboard: Codable {
    let companyName: String
    let logo: String
    let backgroundColor: String
    let mainColor: String
    let cardBackgroundColor: String
    let textColor: String
    let highlightTextColor: String
    let accentColor: String
}

struct CompanyData: Codable {
    let company: Company
    let customerMarkParameters: CustomerMarkParameters
    let mobileAppDashboard: MobileAppDashboard
}
