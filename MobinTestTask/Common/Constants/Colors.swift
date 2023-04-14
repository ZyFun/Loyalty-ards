//
//  Colors.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 14.04.2023.
//

import UIKit

enum Colors {
    static let white = UIColor(hex: "ffffff")
    static let black = UIColor(hex: "1a1a1a")
    static let red = UIColor(hex: "ff3044")
    static let blue = UIColor(hex: "2688eb")
    static let darkGrey = UIColor(hex: "949494")
    static let lightGrey = UIColor(hex: "efefef")
}

enum DynamicColors {
    case cardBackgroundColor(hex: String)
    case highlightTextColor(hex: String)
    case textColor(hex: String)
    case mainColor(hex: String)
    case accentColor(hex: String)
    case backgroundColor(hex: String)
    
    private var hex: String {
        switch self {
        case .cardBackgroundColor(let hex),
                .highlightTextColor(let hex),
                .textColor(let hex),
                .mainColor(let hex),
                .accentColor(let hex),
                .backgroundColor(let hex):
            return hex
        }
    }
    
    var color: UIColor? {
        return UIColor(hex: hex)
    }
}
