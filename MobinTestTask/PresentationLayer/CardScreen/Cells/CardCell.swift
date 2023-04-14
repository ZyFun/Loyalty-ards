//
//  CardCell.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 14.04.2023.
//

import UIKit

class CardCell: UITableViewCell, IdentifiableCell {
    
    // контерйнер вью и другие элементы
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Добавить элементы
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}

// MARK: - Public methods

extension CardCell {
    func config() {
        
    }
}
