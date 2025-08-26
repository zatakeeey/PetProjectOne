import UIKit

public struct Asset {
    public let id: UUID = UUID()
    public let title: String
    public let price: String
    public let category: String
}

public protocol AssetCardDelegate: AnyObject {
    func toggle(favorite asset: Asset)
    func isFavorite(asset: Asset) -> Bool
}

// MARK: - Asset Card Cell (без изменений)
class AssetCardCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let heartButton = UIButton()
    
    private var asset: Asset?
    private weak var delegate: AssetCardDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(asset: Asset, delegate: AssetCardDelegate) {
        self.asset = asset
        self.delegate = delegate
        self.titleLabel.text = asset.title
        self.priceLabel.text = asset.price
        self.heartButton.setImage(UIImage(named: delegate.isFavorite(asset: asset) ? "Favs_done" : "Favs"), for: .normal)
    }
    
    private func setupCardUI() {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = UIColor(hex: "#B3BBD4")
        contentView.addSubview(topView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 170)
        ])
        
        // MARK: - making "CARS" tag
        let badgeView = UIView()
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        badgeView.backgroundColor = UIColor.black.withAlphaComponent(0.7) // ✅ правильно: 70% прозрачность
        badgeView.layer.cornerRadius = 6
        badgeView.layer.maskedCorners = [.layerMinXMinYCorner]
        badgeView.clipsToBounds = true
        
        // Добавляем blur
//        let blurEffect = UIBlurEffect(style: .regular) // можно подобрать стиль, чтобы получить blur ~10
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.translatesAutoresizingMaskIntoConstraints = false
//        blurView.isUserInteractionEnabled = false
//        badgeView.addSubview(blurView)
//        NSLayoutConstraint.activate([
//            blurView.topAnchor.constraint(equalTo: badgeView.topAnchor),
//            blurView.leadingAnchor.constraint(equalTo: badgeView.leadingAnchor),
//            blurView.trailingAnchor.constraint(equalTo: badgeView.trailingAnchor),
//            blurView.bottomAnchor.constraint(equalTo: badgeView.bottomAnchor),
//        ])

        // Текст "CARS"
        let badgeLabel = UILabel()
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.text = "CARS"
        badgeLabel.textColor = UIColor(hex: "#FFFFFF")
        badgeLabel.font = UIFont(name: "PlusJakartaSans-Regular", size: 8) ?? UIFont.systemFont(ofSize: 8)
        badgeLabel.textAlignment = .center
        badgeLabel.layer.opacity = 1.0

        // Настройка letter spacing 5%
        let attributedText = NSMutableAttributedString(string: "CARS")
        attributedText.addAttributes([
            .kern: 0.05 * badgeLabel.font.pointSize,
            .foregroundColor: UIColor.white
        ], range: NSRange(location: 0, length: attributedText.length))
        badgeLabel.attributedText = attributedText
        
        badgeView.addSubview(badgeLabel)

        // Ограничения для текста внутри плашки
        NSLayoutConstraint.activate([
            badgeLabel.centerYAnchor.constraint(equalTo: badgeView.centerYAnchor),
            badgeLabel.centerXAnchor.constraint(equalTo: badgeView.centerXAnchor),
            badgeLabel.widthAnchor.constraint(equalToConstant: 24),
            badgeLabel.heightAnchor.constraint(equalToConstant: 8)
        ])

        // Добавляем плашку в contentView карточки
        contentView.addSubview(badgeView)

        // Ограничения для самой плашки
        NSLayoutConstraint.activate([
            badgeView.widthAnchor.constraint(equalToConstant: 40),
            badgeView.heightAnchor.constraint(equalToConstant: 16),
            badgeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 154),
            badgeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 130)
        ])
        
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = .white
        contentView.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        titleLabel.font = UIFont(name: "PlusJakartaSans-Bold", size: 14) ?? UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -8)
        ])
        
        priceLabel.font = UIFont(name: "PlusJakartaSans-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
        priceLabel.textColor = .black
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 42),
            priceLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -8)
        ])
        
        heartButton.setImage(UIImage(named: "Favs"), for: .normal)
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(heartButton)
        
        NSLayoutConstraint.activate([
            heartButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            heartButton.widthAnchor.constraint(equalToConstant: 24),
            heartButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        heartButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self, let asset, let delegate else { return }
            delegate.toggle(favorite: asset)
        }), for: .touchUpInside)
    }
}
