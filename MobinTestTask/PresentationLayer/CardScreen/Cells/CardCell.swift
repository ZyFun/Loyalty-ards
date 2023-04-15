//
//  CardCell.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 14.04.2023.
//

import UIKit

final class CardCell: UITableViewCell, IdentifiableCell {
    
    weak var delegate: CellButtonActionDelegate?
    
    // MARK: - Private properties
    
    private var imageLoadingManager: IImageLoadingManager
    private var companyId: String?
    
    @UsesAutoLayout
    private var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        return view
    }()
    
    @UsesAutoLayout
    private var companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.systemNormal(.size1).font
        return label
    }()
    
    @UsesAutoLayout
    private var borderViewUp: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    @UsesAutoLayout
    private var companyIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.clipsToBounds = true
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
    
    @UsesAutoLayout
    private var borderViewDown: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    @UsesAutoLayout
    private var eyeButton: UIButton = {
        let button = CardIconButton(type: .system)
        button.setImage(Icons.eye.image, for: .normal)
        button.accessibilityLabel = "Eye Button"
        return button
    }()
    
    @UsesAutoLayout
    private var trashButton: UIButton = {
        let button = CardIconButton(type: .system)
        button.setImage(Icons.trash.image, for: .normal)
        button.accessibilityLabel = "Delete Button"
        return button
    }()
    
    @UsesAutoLayout
    private var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Подробнее", for: .normal)
        button.titleLabel?.font = Fonts.systemNormal(.size2).font
        button.layer.cornerRadius = 15
        button.accessibilityLabel = "Info Button"
        return button
    }()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        imageLoadingManager = ImageLoadingManager()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupRadiusForCompanyIconImage()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        companyNameLabel.text = ""
        companyIconImageView.image = nil
        markLabel.text = ""
        percentLabel.text = ""
        loyaltyNameLabel.text = ""
    }
    
    // MARK: - Private methods
    
    private func setupRadiusForCompanyIconImage() {
        let radius = companyIconImageView.frame.size.width / 2
        companyIconImageView.layer.cornerRadius = radius
    }
    
    @objc func pressedButton(_ sender: UIButton) {
        delegate?.didPressedButton(
            message: "Нажата кнопка \(sender.accessibilityLabel ?? "no name"), id компании: \(companyId ?? "no id")"
        )
    }
}

// MARK: - Public methods

extension CardCell {
    func config(
        companyId: String,
        companyName: String,
        imageUrl: String,
        mark: String,
        percent: String,
        loyaltyName: String,
        hexColors: CardColorsModel,
        delegate: CellButtonActionDelegate?
    ) {
        self.delegate = delegate
        self.companyId = companyId
        
        setImage(from: imageUrl)
        
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
        
        eyeButton.tintColor = UIColor(hex: hexColors.mainColor)
        
        trashButton.tintColor = UIColor(hex: hexColors.accentColor)
        
        infoButton.setTitleColor(UIColor(hex: hexColors.mainColor), for: .normal)
        infoButton.backgroundColor = UIColor(hex: hexColors.backgroundColor)
    }
    
    private func setImage(from url: String) {
        imageLoadingManager.getImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.companyIconImageView.image = image
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.companyIconImageView.image = nil
                    SystemLogger.error(error.describing)
                }
            }
        }
    }
}

// MARK: - Configuration methods

private extension CardCell {
    func setup() {
        setupUI()
        addTargetFromButtons()
    }
    
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func addTargetFromButtons() {
        eyeButton.addTarget(self, action: #selector(pressedButton(_:)), for: .touchUpInside)
        trashButton.addTarget(self, action: #selector(pressedButton(_:)), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(pressedButton(_:)), for: .touchUpInside)
    }
    
    func addViews() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(companyNameLabel)
        containerView.addSubview(companyIconImageView)
        containerView.addSubview(borderViewUp)
        containerView.addSubview(markLabel)
        containerView.addSubview(staticMarkLabel)
        containerView.addSubview(staticPercentLabel)
        containerView.addSubview(percentLabel)
        containerView.addSubview(staticLoyaltyNameLabel)
        containerView.addSubview(loyaltyNameLabel)
        containerView.addSubview(borderViewDown)
        containerView.addSubview(eyeButton)
        containerView.addSubview(trashButton)
        containerView.addSubview(infoButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Indents.red),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Indents.red),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Indents.red),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Indents.red),
                        
            companyIconImageView.heightAnchor.constraint(equalToConstant: Constants.iconCompanySize),
            companyIconImageView.widthAnchor.constraint(equalToConstant: Constants.iconCompanySize),
            companyIconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Indents.red),
            companyIconImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Indents.red),
            
            companyNameLabel.centerYAnchor.constraint(equalTo: companyIconImageView.centerYAnchor, constant: Constants.companyNameOffsetUp),
            companyNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Indents.red),
            
            borderViewUp.heightAnchor.constraint(equalToConstant: Constants.heightBorder),
            borderViewUp.topAnchor.constraint(equalTo: companyIconImageView.bottomAnchor, constant: Indents.yellow),
            borderViewUp.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Indents.red),
            borderViewUp.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Indents.red),
            
            markLabel.topAnchor.constraint(equalTo: borderViewUp.bottomAnchor, constant: Indents.red),
            markLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Indents.red),
            
            staticMarkLabel.leadingAnchor.constraint(equalTo: markLabel.trailingAnchor, constant: Indents.yellow),
            staticMarkLabel.firstBaselineAnchor.constraint(equalTo: markLabel.firstBaselineAnchor),
            
            staticPercentLabel.topAnchor.constraint(equalTo: markLabel.bottomAnchor, constant: Indents.red),
            staticPercentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Indents.red),
            
            percentLabel.topAnchor.constraint(equalTo: staticPercentLabel.bottomAnchor, constant: Indents.yellow),
            percentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Indents.red),
            
            staticLoyaltyNameLabel.firstBaselineAnchor.constraint(equalTo: staticPercentLabel.firstBaselineAnchor),
            staticLoyaltyNameLabel.leadingAnchor.constraint(equalTo: staticPercentLabel.trailingAnchor, constant: Indents.blue),
            
            loyaltyNameLabel.topAnchor.constraint(equalTo: staticLoyaltyNameLabel.bottomAnchor, constant: Indents.yellow),
            loyaltyNameLabel.leadingAnchor.constraint(equalTo: staticLoyaltyNameLabel.leadingAnchor),
            
            borderViewDown.heightAnchor.constraint(equalToConstant: Constants.heightBorder),
            borderViewDown.topAnchor.constraint(equalTo: loyaltyNameLabel.bottomAnchor, constant: Indents.yellow),
            borderViewDown.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Indents.red),
            borderViewDown.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Indents.red),
            
            eyeButton.heightAnchor.constraint(equalToConstant: Constants.iconButtonSize),
            eyeButton.widthAnchor.constraint(equalToConstant: Constants.iconButtonSize),
            eyeButton.topAnchor.constraint(equalTo: borderViewDown.bottomAnchor, constant: Indents.red),
            eyeButton.leadingAnchor.constraint(equalTo: borderViewDown.leadingAnchor, constant: Indents.red-Constants.eyeButtonOffsetY),
            
            trashButton.heightAnchor.constraint(equalToConstant: Constants.iconButtonSize),
            trashButton.widthAnchor.constraint(equalToConstant: Constants.iconButtonSize),
            trashButton.topAnchor.constraint(equalTo: borderViewDown.bottomAnchor, constant: Indents.red),
            trashButton.leadingAnchor.constraint(equalTo: eyeButton.trailingAnchor, constant: Indents.blue),
            
            infoButton.heightAnchor.constraint(equalToConstant: Constants.infoButtonHeight),
            infoButton.widthAnchor.constraint(equalToConstant: Constants.infoBottonWidth),
            infoButton.topAnchor.constraint(equalTo: borderViewDown.bottomAnchor, constant: Indents.yellow),
            infoButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Indents.red),
            infoButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Indents.red),
            
        ])
    }
}

private extension CardCell {
    struct Constants {
        static let iconCompanySize: CGFloat = 48
        static let iconButtonSize: CGFloat = 25
        static let companyNameOffsetUp: CGFloat = -5
        static let heightBorder: CGFloat = 2
        static let infoButtonHeight: CGFloat = 50
        static let infoBottonWidth: CGFloat = 178
        static let eyeButtonOffsetY: CGFloat = 6
    }
}
