//
//  Fonts.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 14.04.2023.
//

import UIKit

enum Fonts {
    case systemNormal
    case systemBold
    
    var font: UIFont {
        switch self {
        case .systemNormal:
            return UIFont.systemFont(ofSize: FontSize.header1.size)
        case .systemBold:
            return UIFont.boldSystemFont(ofSize: FontSize.header1.size)
        }
    }
}

enum FontSize {
    case header1
    case header2
    
    var size: CGFloat {
        switch self {
        case .header1: return 26.0
        case .header2: return 20.0
        }
    }
}
