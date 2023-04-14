//
//  Fonts.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 14.04.2023.
//

import UIKit

enum Fonts {
    case systemNormal(_ size: FontSize)
    case systemBold(_ size: FontSize)
    
    var font: UIFont {
        switch self {
        case .systemNormal(let size):
            return UIFont.systemFont(ofSize: size.size)
        case .systemBold(let size):
            return UIFont.boldSystemFont(ofSize: size.size)
        }
    }
}

enum FontSize {
    case size1
    case size2
    case size3
    
    var size: CGFloat {
        switch self {
        case .size1: return 26.0
        case .size2: return 20.0
        case .size3: return 15.0
        }
    }
}
