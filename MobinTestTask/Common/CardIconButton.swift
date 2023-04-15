//
//  CardIconButton.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 15.04.2023.
//

import UIKit

/// Класс с переопределенным методом, для увеличения области нажатия у небольших кнопок
final class CardIconButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        bounds.insetBy(dx: -20, dy: -20).contains(point)
    }
}
