//
//  CardCell.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 14.04.2023.
//

import UIKit

// TODO: Нужен делегат для кнопок ячейки

class CardCell: UITableViewCell, IdentifiableCell {
    
    // MARK: - Private properties
    
    @UsesAutoLayout
    private var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    @UsesAutoLayout
    private var companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.systemNormal(.size1).font
        return label
    }()
    
    // TODO: Сделать загрузку изображений
    @UsesAutoLayout
    private var companyIconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    @UsesAutoLayout
    private var markLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.systemBold(.size1).font
        return label
    }()
    
    @UsesAutoLayout
    private var staticMarkLabel: UILabel = {
        let label = UILabel()
        label.text = "баллов"
        label.font = Fonts.systemNormal(.size2).font
        return label
    }()
    
    @UsesAutoLayout
    private var percentLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.systemNormal(.size2).font
        return label
    }()
    
    @UsesAutoLayout
    private var staticPercentLabel: UILabel = {
        let label = UILabel()
        label.text = "Кешбэк"
        label.font = Fonts.systemNormal(.size3).font
        return label
    }()
    
    @UsesAutoLayout
    private var loyaltyNameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.systemNormal(.size2).font
        return label
    }()
    
    @UsesAutoLayout
    private var staticLoyaltyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Уровень"
        label.font = Fonts.systemNormal(.size3).font
        return label
    }()
    
    // TODO: Донастроить и добавить структуру с иконками
    // которая будет принимать цвет с сервера
    @UsesAutoLayout
    private var eyeButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    @UsesAutoLayout
    private var trashButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    @UsesAutoLayout
    private var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Подробнее", for: .normal)
        button.titleLabel?.font = Fonts.systemNormal(.size2).font
        return button
    }()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // TODO: Добавить элементы
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // TODO: Добавить элементы
        ])
    }
}

// MARK: - Public methods

// TODO: let imageUrl: String
extension CardCell {
    func config(
        companyName: String,
        mark: String,
        percent: String,
        loyaltyName: String,
        hexColors: CardColorsModel
    ) {
        containerView.backgroundColor = UIColor(hex: hexColors.cardBackgroundColor)
        
        companyNameLabel.text = companyName
        companyNameLabel.textColor = UIColor(hex: hexColors.highlightTextColor)
        
        markLabel.text = mark
        markLabel.textColor = UIColor(hex: hexColors.highlightTextColor)
        staticMarkLabel.textColor = UIColor(hex: hexColors.textColor)
        
        percentLabel.text = "\(percent) %"
        percentLabel.textColor = UIColor(hex: hexColors.highlightTextColor)
        staticPercentLabel.textColor = UIColor(hex: hexColors.textColor)
        
        loyaltyNameLabel.text = loyaltyName
        loyaltyNameLabel.textColor = UIColor(hex: hexColors.highlightTextColor)
        staticLoyaltyNameLabel.textColor = UIColor(hex: hexColors.textColor)
        
        infoButton.setTitleColor(UIColor(hex: hexColors.mainColor), for: .normal)
    }
}
