import UIKit

class NewsCardCell: UITableViewCell {
    
    // MARK: - News Card 1
    // верхняя часть карточки новостей
    private let imageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#B3BBD4")
        view.clipsToBounds = true
        view.layer.cornerRadius = 32
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
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    }()
    
    // описание карточки новостей
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if let customFont = UIFont(name: "PlusJakartaSans-Regular", size: 12) {
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
        let button = UIButton(type: .system)
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
        

        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.image = UIImage(named: "Chevron_Read_more")
            config.imagePlacement = .trailing
            config.imagePadding = 10
            config.contentInsets = NSDirectionalEdgeInsets(top: 17, leading: 98, bottom: 17, trailing: 98)
            button.configuration = config
        } else {
            if let chevronImage = UIImage(named: "Chevron_Read_more") {
                button.setImage(chevronImage, for: .normal)
                button.imageView?.contentMode = .scaleAspectFit
                button.semanticContentAttribute = .forceRightToLeft
                button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
                button.contentEdgeInsets = UIEdgeInsets(top: 17, left: 98, bottom: 17, right: 98)
            }
        }
        
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    // контейнер для текста
    private let contentContainer: UIView = {
        let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 32 // ← ИЗМЕНИЛИ НА 32
            view.clipsToBounds = true
            return view
        }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupButtonActions()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupButtonActions()
        selectionStyle = .none
    }
    
    // MARK: - Setup
    private func setupViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 32
        contentView.clipsToBounds = true
        
        contentView.addSubview(contentContainer)
        contentView.addSubview(imageContainer)
        
        // контент нижней части
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
            // верхний блок с отступами
            imageContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageContainer.heightAnchor.constraint(equalToConstant: 240),
            
            // нижний блок с отступами
            contentContainer.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
            // текстовый стек
            textStack.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: -16),
            textStack.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            textStack.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            textStack.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
            
            // фиксированные размеры кнопки
            readMoreButton.widthAnchor.constraint(equalToConstant: 341),
            readMoreButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            readMoreButton.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor)
        ])
    }
    
    private func setupButtonActions() {
        // обработка нажатия
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
        descriptionLabel.text = description // ← Исправьте, чтобы использовалось переданное описание
    }
    
    // MARK: - Layout
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
            return size
    }
}
