//
//  CompanyAPIModel.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 13.04.2023.
//

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
