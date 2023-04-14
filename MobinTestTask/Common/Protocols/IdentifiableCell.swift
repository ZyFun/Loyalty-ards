//
//  IdentifiableCell.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 14.04.2023.
//

protocol IdentifiableCell {}

extension IdentifiableCell {
    static var identifier: String {
        String(describing: Self.self)
    }
}
