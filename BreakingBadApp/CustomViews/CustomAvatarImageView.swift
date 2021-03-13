//
//  CustomAvatarImageView.swift
//  BreakingBadApp
//
//  Created by Melvin Asare on 13/03/2021.
//

import UIKit

class CustomAvatarImageView: UIImageView {

    func configure(image: UIImage) {
        self.image = image
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
    }
}

private extension CustomAvatarImageView {
    func setup() {
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(avatarPressed))
        addGestureRecognizer(tapGuesture)

        self.backgroundColor = .systemBlue
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc func avatarPressed() {
    }
}
