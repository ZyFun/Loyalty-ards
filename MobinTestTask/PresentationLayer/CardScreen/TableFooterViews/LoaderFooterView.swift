//
//  LoaderFooterView.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 18.04.2023.
//

import UIKit

protocol ILoaderFooterView {
    func startAnimating()
    func stopAnimating()
}

final class LoaderFooterView: UIView, ILoaderFooterView {
    
    // MARK: - Private properties
    
    private var containerViewHeight = NSLayoutConstraint()
    
    @UsesAutoLayout
    private var activityIndicator: HalfRingActivityIndicator = {
        let activityIndicator = HalfRingActivityIndicator()
        return activityIndicator
    }()
    
    @UsesAutoLayout
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Подгрузка компаний"
        label.textColor = Colors.black
        return label
    }()
    
    @UsesAutoLayout
    private var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Private methods
    
    private func addViews() {
        addSubview(containerView)
        containerView.addSubview(activityIndicator)
        containerView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: Indents.yellow),

            descriptionLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: Indents.yellow),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}
