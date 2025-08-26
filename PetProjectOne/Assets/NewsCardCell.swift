//
//  NewsCardCell.swift
//  PetProjectOne
//
//  Created by Георгий Полежаев on 25.08.2025.
//

import UIKit

class NewsCardCell: UIView {
    
    // MARK: - News Card 1
    // вехрняя часть карточки новостей
    private let imageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#B3BBD4")
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    // заголовок карточки новостей
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if let customFont = UIFont(name: "PlusJakartaSans-ExtraBold", size: 16) {
            label.font = customFont
        } else {
            label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        }
        
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    // описание карточки новостей
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if let customFont = UIFont(name: "PlusJakartaSans-Regular", size: 14) {
            label.font = customFont
        } else {
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
        
        label.textColor = UIColor(hex: "#666666")
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // кнопка Read More
    private let readMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Черный фон и овальная форма
        button.backgroundColor = .black
        button.layer.cornerRadius = 22
        button.clipsToBounds = true
        
        // Текст кнопки
        button.setTitle("Read More", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        // Шрифт текста
        if let customFont = UIFont(name: "PlusJakartaSans-SemiBold", size: 14) {
            button.titleLabel?.font = customFont
        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        }
        
        // Иконка шеврона справа
        if let chevronImage = UIImage(named: "Chevron_Read_more") {
            button.setImage(chevronImage, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.semanticContentAttribute = .forceRightToLeft
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }
        
        // Большие отступы для вытянутой формы
        button.contentEdgeInsets = UIEdgeInsets(top: 17, left: 98, bottom: 17, right: 98)
        
        // Включаем взаимодействие
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    //контейнер для текста
    private let contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
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
        backgroundColor = .white
        layer.cornerRadius = 12
        clipsToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        // Добавляем контейнеры
        addSubview(imageContainer)
        addSubview(contentContainer)
        
        // Контент нижней части
        let textStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, readMoreButton])
        textStack.axis = .vertical
        textStack.spacing = 12
        textStack.isLayoutMarginsRelativeArrangement = true
        textStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentContainer.addSubview(textStack)
        
        // Констрейнты
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Верхний блок
            imageContainer.topAnchor.constraint(equalTo: topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageContainer.heightAnchor.constraint(equalToConstant: 240),
            
            // Нижний блок
            contentContainer.topAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            contentContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Текстовый стек
            textStack.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            textStack.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            textStack.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            textStack.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
            
            // Фиксированные размеры кнопки
            readMoreButton.widthAnchor.constraint(equalToConstant: 341),
            readMoreButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // Центрируем кнопку по горизонтали
        NSLayoutConstraint.activate([
            readMoreButton.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor)
        ])
    }
    
    private func setupButtonActions() {
        // Обработка нажатия
        readMoreButton.addTarget(self, action: #selector(buttonTouchedDown), for: .touchDown)
        readMoreButton.addTarget(self, action: #selector(buttonTouchedUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        readMoreButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    // MARK: - Анимация/активация кнопки Read More
    @objc private func buttonTouchedDown() {
        UIView.animate(withDuration: 0.1) {
            self.readMoreButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.readMoreButton.alpha = 0.8
        }
        print("Кнопка нажата 🔽")
    }
    
    @objc private func buttonTouchedUp() {
        UIView.animate(withDuration: 0.2) {
            self.readMoreButton.transform = .identity
            self.readMoreButton.alpha = 1.0
        }
        print("Кнопка отпущена 🔼")
    }
    
    @objc private func buttonTapped() {
        print("Кнопка 'Read More' tapped! ✅")
        
        // Дополнительная анимация подтверждения
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
        descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
    
    // MARK: - Layout
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 361, height: 411)
    }
}
