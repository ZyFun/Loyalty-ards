//
//  PostmanModel.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 13.04.2023.
//

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
