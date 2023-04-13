//
//  ServiceAssembly.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 13.04.2023.
//

import Foundation

final class ServiceAssembly {
    lazy var requestService: IRequestSender = {
        return RequestSender()
    }()
}
