//
//  URLProvider.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 13.04.2023.
//

import Foundation

public struct URLProvider: IRequest {
    var urlRequest: URLRequest?
    
    // TODO: В этом нет необходимости, можно удалить после рефакторинга запросов
    public static func fetchRequestJSONUrl() -> URL {
        guard let url = Bundle.main.url(
            forResource: "TaskForAppleAppDelelopers.postman_collection",
            withExtension: "json"
        ) else {
            fatalError("Unable to find file in the app bundle")
        }
        
        return url
    }
}
