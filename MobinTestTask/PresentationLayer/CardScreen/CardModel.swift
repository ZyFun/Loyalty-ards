//
//  CardModel.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 14.04.2023.
//

import Foundation

struct CardModel: Hashable {
    let id: String
    let name: String
    let imageUrl: String
    let mark: String
    let loyaltyName: String
    let percent: String
    let hexColors: CardColorsModel
}

struct CardColorsModel: Hashable {
    let cardBackgroundColor: String
    let highlightTextColor: String
    let textColor: String
    let mainColor: String
    let accentColor: String
    let backgroundColor: String
}
