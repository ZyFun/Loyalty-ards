//
//  RequestModel.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 13.04.2023.
//

import Foundation

struct RequestModel {
    let method: String
    let header: [Header]
    let body: Body
    let url: URL
}
