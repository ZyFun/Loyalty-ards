//
//  ImageLoadingManager.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 15.04.2023.
//

import UIKit
import DTLogger

protocol IImageLoadingManager {
    func getImage(from url: String, completion: @escaping (Result<UIImage?, NetworkError>) -> Void)
}

final class ImageLoadingManager: IImageLoadingManager {
    private let requestSender: IRequestSender
    private var image: UIImage?
    /// Используется для проверки при загрузке ячейки,
    /// чтобы предотвратить загрузку изображения не в ту ячейку
    private var imageUrlString: String = ""
    
    init() {
        requestSender = RequestSender()
    }
    
    func getImage(from url: String, completion: @escaping (Result<UIImage?, NetworkError>) -> Void) {
        imageUrlString = url
        
        guard let urlForCache = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        if let cachedImage = getCachedImage(from: urlForCache) {
            image = cachedImage
            completion(.success(image))
            return
        }
        
        let requestConfig = RequestFactory.CompanyRequest.imageCompanyConfig(from: url)
        requestSender.send(config: requestConfig) { [weak self] result in
            switch result {
            case .success(let (_, data, response)):
                guard self?.imageUrlString == url else { return }
                guard let data = data else {
                    SystemLogger.error("Ошибка получения данных, возможно в коде")
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    completion(.failure(.noImage))
                    return
                }
                completion(.success(image))
                
                guard let response = response else {
                    SystemLogger.error("Вероятно ошибка в коде")
                    return
                }
                self?.saveDataToCache(with: data, response: response)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func saveDataToCache(with data: Data, response: URLResponse) {
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        
        return nil
    }
}
