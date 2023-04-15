//
//  Icons.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 15.04.2023.
//

import UIKit

enum Icons: String {
    case eye
    case trash
}

extension Icons {
    var image: UIImage? {
        UIImage(named: self.rawValue)?.withRenderingMode(.alwaysTemplate)
    }
}
