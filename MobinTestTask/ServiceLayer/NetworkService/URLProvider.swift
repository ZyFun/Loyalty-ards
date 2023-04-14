//
//  URLProvider.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 14.04.2023.
//

import Foundation

public struct URLProvider {
    public static func getAllCardsUrl() -> URL {
        guard let url = URL(string: "http://dev.bonusmoney.pro/mobileapp/getAllCompanies") else {
            SystemLogger.error("Не удалось преобразовать String в URL")
            fatalError()
        }
        
        return url
    }
}
