//
//  ProfileViewController.swift
//  BreakingBadApp
//
//  Created by Melvin Asare on 14/03/2021.
//

import PanModal
import SDWebImage

class ProfileViewController: UIViewController {

    private lazy var avatarImageView: CustomAvatarImageView = {
        let imageView = CustomAvatarImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var characterNameLabel: CustomTitleLabel = {
        let label = CustomTitleLabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var occupationLabel: CustomTitleLabel = {
        let label = CustomTitleLabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .center, fontSize: 16, fontColor: .darkGray, fontWeight: .regular)
        return label
    }()

    private var seasonLabel: CustomTitleLabel = {
        let label = CustomTitleLabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .center, fontSize: 16, fontColor: .darkGray, fontWeight: .regular)
        return label
    }()

    private lazy var statusImageView: CustomAvatarImageView = {
        let imageView = CustomAvatarImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImageShowText))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()

    private var statusLabel: CustomTitleLabel = {
        let label = CustomTitleLabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .center, fontSize: 16, fontColor: .darkGray, fontWeight: .regular)
        label.isHidden = true
        return label
    }()

    @objc func tapImageShowText() {
        if viewModel.showStatusLabel == false {
            viewModel.showStatusLabel = true
            statusLabel.isHidden = false
        } else if viewModel.showStatusLabel == true {
            viewModel.showStatusLabel = false
            statusLabel.isHidden = true
        }
    }

    private func attributedString(for username: String) -> NSAttributedString {
        let nickname = " (\(viewModel.characterData.nickname))"
        let paragraphStyle = NSMutableParagraphStyle()
        let combinedString = "\(username) \(nickname)"
        let usernameStringAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont.systemFont(ofSize: 22, weight: .heavy),
        ]
        let nicknametStringAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 18, weight: .regular)
        ]
        let attString = NSMutableAttributedString(string: combinedString)

        attString.addAttributes(usernameStringAttributes, range: (combinedString as NSString).range(of: username))
        attString.addAttributes(nicknametStringAttributes, range: (combinedString as NSString).range(of: nickname))
        attString.addAttributes([.paragraphStyle: paragraphStyle], range: (combinedString as NSString).range(of: combinedString))
        return attString
    }

    private var viewModel: ProfileViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCharacterData() {
        statusLabel.text = viewModel.characterData.status
        avatarImageView.sd_setImage(with: URL(string: viewModel.characterData.img))
        characterNameLabel.attributedText = attributedString(for: viewModel.characterData.name)
        characterNameLabel.textAlignment = .center
        characterNameLabel.numberOfLines = 0
        occupationLabel.text = viewModel.characterData.occupation.joined(separator: ", ")
        seasonLabel.text = "Season Appearances \(viewModel.characterData.appearance)"
        if viewModel.characterData.status == "Alive" {
            statusImageView.configure(image: UIImage(named: "alive")!)
        } else if viewModel.characterData.status == "Deceased" {
            statusImageView.configure(image: UIImage(named: "deceased")!)
        } else {
            statusImageView.configure(image: UIImage(named: "unknown")!)
        }
    }
}

extension ProfileViewController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(280)
    }

    var showDragIndicator: Bool {
        return false
    }

    var anchorModalToLongForm: Bool {
        return false
    }
}

private extension ProfileViewController {
    func setup() {
        view.backgroundColor = .white

        view.addSubview(avatarImageView)
        view.addSubview(characterNameLabel)
        view.addSubview(occupationLabel)
        view.addSubview(statusImageView)
        view.addSubview(seasonLabel)
        view.addSubview(statusLabel)

        configureCharacterData()

        avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.padding).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true

        characterNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Constants.gap).isActive = true
        characterNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.imageViewDimensions).isActive = true
        characterNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.imageViewDimensions).isActive = true

        occupationLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: Constants.gap).isActive = true
        occupationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding).isActive = true
        occupationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding).isActive = true

        seasonLabel.topAnchor.constraint(equalTo: occupationLabel.bottomAnchor, constant: 5).isActive = true
        seasonLabel.leadingAnchor.constraint(equalTo: occupationLabel.leadingAnchor).isActive = true
        seasonLabel.trailingAnchor.constraint(equalTo: occupationLabel.trailingAnchor).isActive = true

        statusImageView.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor).isActive = true
        statusImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 30).isActive = true
        statusImageView.heightAnchor.constraint(equalToConstant: Constants.imageViewDimensions).isActive = true
        statusImageView.widthAnchor.constraint(equalToConstant: Constants.imageViewDimensions).isActive = true

        statusLabel.bottomAnchor.constraint(equalTo: statusImageView.topAnchor, constant: -8).isActive = true
        statusLabel.centerXAnchor.constraint(equalTo: statusImageView.centerXAnchor).isActive = true
    }

    struct Constants {
        static let padding: CGFloat = 20
        static let imageViewDimensions: CGFloat = 40
        static let gap: CGFloat = 15
        static let avatarImageDimension: CGFloat = 150
    }
}
