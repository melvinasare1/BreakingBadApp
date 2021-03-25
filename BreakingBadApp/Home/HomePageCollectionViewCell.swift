//
//  HomePageCollectionViewCell.swift
//  BreakingBadApp
//
//  Created by Melvin Asare on 13/03/2021.
//

import UIKit
import SDWebImage

class HomePageCollectionViewCell: UICollectionViewCell {

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    private var characterNameLabel: CustomTitleLabel = {
        let label = CustomTitleLabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .center, fontSize: 14, fontColor: .darkGray, fontWeight: .heavy)
        return label
    }()

    func configure(with character: Character) {
        avatarImageView.sd_setImage(with: URL(string: character.img))
        characterNameLabel.text = character.name
       avatarImageView.downloadCache(url: character.img, imageView: self.avatarImageView)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HomePageCollectionViewCell {

    func setup() {
        addSubview(avatarImageView)
        addSubview(characterNameLabel)

        avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding).isActive = true
        avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true

        characterNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12).isActive = true
        characterNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding).isActive = true
        characterNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding).isActive = true
    }

    struct Constants {
        static let padding: CGFloat = 8
    }
}
