//
//  NewsCardCellSimple.swift
//  PetProjectOne
//
//  Created by Георгий Полежаев on 25.08.2025.
//

import UIKit

class NewsCardCellSimple: UIView {
    
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if let customFont = UIFont(name: "PlusJakartaSans-ExtraBold", size: 16) {
            label.font = customFont
        } else {
            label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        }
        
        label.textColor = .black
        label.numberOfLines = 2 // две строки для длинного заголовка
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if let customFont = UIFont(name: "PlusJakartaSans-Regular", size: 14) {
            label.font = customFont
        } else {
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
        
        label.textColor = UIColor(hex: "#666666")
        label.numberOfLines = 3 // три строки текста
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail // троеточие в конце
        return label
    }()
    
    private let readMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = .black
        button.layer.cornerRadius = 22
        button.clipsToBounds = true
        
        button.setTitle("Read More", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        if let customFont = UIFont(name: "PlusJakartaSans-SemiBold", size: 14) {
            button.titleLabel?.font = customFont
        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        }
        
        if let chevronImage = UIImage(named: "Chevron_Read_more") {
            button.setImage(chevronImage, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.semanticContentAttribute = .forceRightToLeft
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }
        
        button.contentEdgeInsets = UIEdgeInsets(top: 17, left: 98, bottom: 17, right: 98)
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupButtonActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupButtonActions()
    }
    
    // MARK: - Setup
    private func setupViews() {
        // Основные настройки карточки
        backgroundColor = .white
        layer.cornerRadius = 32
        clipsToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        // Добавляем элементы в стек
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(descriptionLabel)
        contentStack.addArrangedSubview(readMoreButton)
        
        addSubview(contentStack)
        
       
        NSLayoutConstraint.activate([
            // стек заполняет всю карточку
            contentStack.topAnchor.constraint(equalTo: topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // фиксированный размер кнопки
            readMoreButton.widthAnchor.constraint(equalToConstant: 341),
            readMoreButton.heightAnchor.constraint(equalToConstant: 44),
            
            // центрирование кнопки
            readMoreButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupButtonActions() {
        readMoreButton.addTarget(self, action: #selector(buttonTouchedDown), for: .touchDown)
        readMoreButton.addTarget(self, action: #selector(buttonTouchedUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        readMoreButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    // MARK: - Button Actions (такие же как в первой карточке)
    @objc private func buttonTouchedDown() {
        UIView.animate(withDuration: 0.1) {
            self.readMoreButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.readMoreButton.alpha = 0.8
        }
    }
    
    @objc private func buttonTouchedUp() {
        UIView.animate(withDuration: 0.2) {
            self.readMoreButton.transform = .identity
            self.readMoreButton.alpha = 1.0
        }
    }
    
    @objc private func buttonTapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.readMoreButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.readMoreButton.transform = .identity
            }
        }
    }
    
    // MARK: - Configuration
    func configure(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    // MARK: - Layout
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 361, height: 203) // точный размер карточки
    }
}
