import UIKit

class ViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private var assets: [Asset] = [
        Asset(title: "BMW M5", price: "10 000 USD", category: "Cars"),
        Asset(title: "Mercedes C", price: "12 000 USD", category: "Cars"),
        Asset(title: "Tesla Model S", price: "1 000 USD", category: "Cars")
    ]
    private var favorites: Set<UUID> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F4F4F4")
        
        setupNavBar()
        setupBottomNavBar()
        setupTableView()
    }
    
    // MARK: - Top navbar (без изменений)
    private func setupNavBar() {
        let navBarView = UIView()
        navBarView.translatesAutoresizingMaskIntoConstraints = false
        navBarView.backgroundColor = UIColor(hex: "#FFFFFF")
        view.addSubview(navBarView)
        
        NSLayoutConstraint.activate([
            navBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBarView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        let topSafeAreaBackground = UIView()
        topSafeAreaBackground.backgroundColor = UIColor(hex: "#FFFFFF")
        topSafeAreaBackground.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topSafeAreaBackground)
        
        NSLayoutConstraint.activate([
            topSafeAreaBackground.topAnchor.constraint(equalTo: view.topAnchor),
            topSafeAreaBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topSafeAreaBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topSafeAreaBackground.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        let avatarImageView = UIImageView()
        avatarImageView.backgroundColor = UIColor(hex: "#B3BBD4")
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 8
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        navBarView.addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: navBarView.topAnchor, constant: 8),
            avatarImageView.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: -8),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor)
        ])
        
        let nameLabel = UILabel()
        nameLabel.text = "Ed Shugar"
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        navBarView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor)
        ])
        
        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(named: "R_Icons"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.imageView?.contentMode = .scaleAspectFit
        navBarView.addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            settingsButton.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor, constant: -16),
            settingsButton.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 24),
            settingsButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK: - Bottom navbar (без изменений)
    private func setupBottomNavBar() {
        let bottomSafeAreaBackground = UIView()
        bottomSafeAreaBackground.backgroundColor = UIColor.white
        bottomSafeAreaBackground.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomSafeAreaBackground)
        
        NSLayoutConstraint.activate([
            bottomSafeAreaBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSafeAreaBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSafeAreaBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSafeAreaBackground.heightAnchor.constraint(equalToConstant: 29)
        ])
        
        let bottomNavBar = UIView()
        bottomNavBar.backgroundColor = UIColor.white
        bottomNavBar.layer.cornerRadius = 16
        bottomNavBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomNavBar.clipsToBounds = true
        bottomNavBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomNavBar)
        
        NSLayoutConstraint.activate([
            bottomNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomNavBar.bottomAnchor.constraint(equalTo: bottomSafeAreaBackground.topAnchor),
            bottomNavBar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: - TableView
    private func setupTableView() {
        tableView.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(NewsCardCellSimple.self, forCellReuseIdentifier: "NewsCardCellSimple")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -89)
        ])
    }
}

// MARK: - UITableView DataSource & Delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3 // всегда 3 секции: Assets, Favorites, News
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        switch indexPath.section {
        case 0:
            setupCollectionView(in: cell, tag: 0)
        case 1:
            setupCollectionView(in: cell, tag: 1)
        case 2:
            setupNewsSection(in: cell)
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 240 + 24 // CollectionView + отступы
        case 1: return favorites.isEmpty ? 0 : 240 + 24 // скрываем если пусто
        case 2: return UITableView.automaticDimension // автоматическая высота news
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        switch section {
        case 0:
            titleLabel.text = "My Assets"
            titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        case 1:
            // скрываем заголовок если нет избранных
            guard !favorites.isEmpty else { return nil }
            
            titleLabel.text = "Favorites"
            titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            
            let subLabel = UILabel()
            subLabel.text = "My favorites assets"
            subLabel.font = UIFont(name: "PlusJakartaSans-Regular", size: 10)
            subLabel.textColor = .darkGray
            subLabel.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(subLabel)
            
            NSLayoutConstraint.activate([
                subLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4)
            ])
        case 2:
            titleLabel.text = "News"
            titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            
            let subLabel = UILabel()
            subLabel.text = "Articles and blog"
            subLabel.font = UIFont(name: "PlusJakartaSans-Regular", size: 10)
            subLabel.textColor = .darkGray
            subLabel.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(subLabel)
            
            NSLayoutConstraint.activate([
                subLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4)
            ])
        default: break
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 47
        case 1: return favorites.isEmpty ? 0 : 80 // скрываем заголовок если пусто
        case 2: return 80
        default: return 0
        }
    }
    
    // MARK: - Настройка секций
    private func setupCollectionView(in cell: UITableViewCell, tag: Int) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: 170, height: 240)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AssetCardCell.self, forCellWithReuseIdentifier: "AssetCardCell")
        collectionView.tag = tag
        cell.contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    private func setupNewsSection(in cell: UITableViewCell) {
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let newsItems = [
            (title: "Lorem ipsum dolor",
             description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
            
            (title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
             description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud ex...")
        ]
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(stackView)
        
        for newsItem in newsItems {
            let newsCardCell = NewsCardCell()
            newsCardCell.configure(title: newsItem.title, description: newsItem.description)
            newsCardCell.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.addArrangedSubview(newsCardCell)
            
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: cell.contentView.bottomAnchor, constant: -12)
        ])
    }
}

// MARK: - UICollectionView DataSource
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0: return assets.count
        case 1: return favorites.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssetCardCell", for: indexPath) as? AssetCardCell else {
            return UICollectionViewCell()
        }
        
        let assets: [Asset] = {
            switch collectionView.tag {
            case 0: return self.assets
            case 1: return self.assets.filter { favorites.contains($0.id) }
            default: return []
            }
        }()
        
        cell.configure(asset: assets[indexPath.item], delegate: self)
        return cell
    }
}

extension ViewController: AssetCardDelegate {
    func toggle(favorite asset: Asset) {
        let id = asset.id
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
        tableView.reloadData()
    }
    
    func isFavorite(asset: Asset) -> Bool {
        favorites.contains(asset.id)
    }
}
